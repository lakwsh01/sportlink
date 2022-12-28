from datetime import datetime, timedelta
import json
import time


def stamp():
    ss = time.time()
    return int((ss)*1000)


def date_tag_builder(offset: timedelta = timedelta(days=2)):
    md = datetime.now()
    if(offset):
        md -= offset
    dd: str = str(md.day)
    mm: str = str(md.month)
    yy: str = str(md.year)

    if(len(dd) == 1):
        dd = f"0{dd}"

    if(len(mm) == 1):
        mm = f"0{mm}"
    return f"{yy}{mm}{dd}"


def region_getter(address: str):
    file_path = ("helper/regions.json")
    # print(f"file_path {file_path}")

    with open(file_path, 'r', encoding='utf-8') as jsonfy:
        from json import loads
        regions: dict = loads(jsonfy.read())
        for key, value in regions.items():
            tags = value.get("search_tags")
            for tag in tags:
                if(tag in address):
                    return key

        return None


def load_area(latlngbounds: str):
    # print(latlngbounds, " at raw input /// and type at : ", type(latlngbounds))
    latlngbounds_list = json.loads(latlngbounds)
    # print(latlngbounds_list, " at first convert /// and type at : ",
    #       type(latlngbounds_list))

    try:
        if(len(latlngbounds_list) == 2 and len(latlngbounds_list[0]) == 2 and len(latlngbounds_list[1]) == 2):
            return {'ne_lat': latlngbounds_list[1][0], 'ne_lng': latlngbounds_list[1][1],
                    'sw_lng': latlngbounds_list[0][1], 'sw_lat': latlngbounds_list[0][0]}
        else:
            raise Exception("Input is not vaild latlngbounds format")
    except Exception as e:
        print(' decoding error : ', str(e))
