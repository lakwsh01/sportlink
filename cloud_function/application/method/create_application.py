

from helper.content_restructure import dict_to_json, simple_restructure_to_psql


def sql_insert_to_application(app: dict):
    jsonb_keys = ["assistant"]
    timestamp_keys = ["expiry"]
    data = {
        "game": None,
        "target_user": None,
        "assistant": None,
        "expiry": None}
    for k in data.keys():
        value: str
        if (k in jsonb_keys):
            value = dict_to_json(app.get(k))
        elif (k in timestamp_keys):
            value = simple_restructure_to_psql(key='dt', value=app.get(k))
        else:
            value = simple_restructure_to_psql(key=k, value=app.get(k))

        if (value):
            data[k] = value
    from method.sql_data_builder.application import full
    sql = """
            INSERT INTO application ({keys})
            SELECT {vs}
            where (SELECT vacancy > 0 from game where game.id = '{game}')
            returning {data};
        """.format(
        game=app['game'],
        data=full,
        keys=",".join(data.keys()), vs=','.join(data.values()))

    return sql
