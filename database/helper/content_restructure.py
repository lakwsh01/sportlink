from json import dumps
from helper.tools import stamp


def simple_restructure_to_psql(key: str, value: any):
    t = type(value)
    if (not value):
        return 'Null'
    elif (key == "geog"):
        if (t == list):
            return geog_builder(lat=value[0], lng=value[-1])
        elif (t == dict):
            return geog_builder(lat=value['lat'], lng=value['lng'])
        else:
            return 'Null'

    elif (key == "md" or key == "creation"):
        return dt_to_psql_timestamp(md_mill=value)
    elif (not value):
        return 'Null'
    elif (t is dict):
        return dict_to_hstore(data=value)
    elif (t is list):
        return list_to_psql_array(array=value)
    elif (t is str):
        return string_to_psql_string(string=value)
    else:
        return f'{value}'


def dict_to_hstore(data: dict):
    """
    {
    'key':'value',
    'key2':'value2'
    }
    """

    if (data):
        migrate = ["\"{k}\" => {v}".format(
            k=k, v='\"{}\"'.format(str(v).replace('\'', '\'\'')) if v else "NULL") for k, v in data.items()]
        return "\'{}\'".format(",".join(migrate))
    elif (data == None):
        return "NULL"
    else:
        return "\'\'::hstore"


def dict_to_json(data: dict):
    """
    {
    'key':'value',
    'key2':'value2'
    }
    """

    if (data):
        # psqlJson = {}
        # for k, v in data.items():
        #     t = type(v)
        #     if (t == list):
        #         psqlJson[k] = list_to_psql_array(v)
        #     elif (t == str):
        #         psqlJson[k] = v

        return dumps(data)
    else:
        return "NULL"


def list_to_psql_array(array: list, nullable: bool = False, repeatable: bool = False):
    """
    {
    'key':'value',
    'key2':'value2'
    }
    """

    if (array):
        _array: list = []
        for i in array:
            if i is None and not nullable:
                _array.append(f'NULL')
            elif i is not None:
                if (type(i) is str):
                    _array.append(f"\'{i}\'")
                else:
                    _array.append(f'{i}')
            else:
                pass
        if (not repeatable):
            _array_set: set = set(_array)
            _array = list(_array_set)

        return "ARRAY[{}]".format(",".join(_array))
    else:
        return "Null"


def dt_builder(time_string: str):
    const_hh = 3600000
    const_mn = 60000
    mn: int
    hh: int
    if (time_string.endswith('00')):
        mn = 0
    else:
        mn_str = time_string[-2:]
        mn_count = int(mn_str)
        mn = const_mn * mn_count

    if (time_string.startswith('00')):
        hh = 0
    else:
        hh_str = time_string[:2]
        hh_count = int(hh_str)
        hh = const_hh * hh_count

    dt = mn+hh
    # print('digital time of day : ', dt)
    return dt


def geog_builder(lat: str, lng: str):
    return "\'SRID=4326;POINT({} {})\'::geometry".format(
        lng,
        lat)


def dt_to_psql_timestamp(md_mill: int = None):
    md = md_mill/1000 if md_mill else stamp()/1000
    md_timestamp = f"to_timestamp({md})"
    return md_timestamp


def string_to_psql_string(string: str):
    if (string):
        string = string.replace('\'', '\'\'')
        return f"\'{string}\'"
    else:
        return f"Null"
