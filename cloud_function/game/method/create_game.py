
from helper.content_restructure import dict_to_json, dt_to_psql_timestamp, simple_restructure_to_psql


def sql_insert_to_game(game: dict):
    keys = [
        "title", "description", "game_mode", "field", "price", "repeation",
        "vacancy", "field_rule", "game_type", "max_player_count", "venue"
    ]
    jsonb_keys = ["permission", "equipment", "assistant", "limited_to"]
    period_start = game["start"]
    period_expiry = game["expiry"]
    data = {
        "period": "Array[{start},{expiry}]".format(start=dt_to_psql_timestamp(
            period_start), expiry=dt_to_psql_timestamp(period_expiry))
    }
    for k in jsonb_keys:
        value = f"\'{dict_to_json(game.get(k))}\'::jsonb"
        data[k] = 'Null' if (value == "'NULL'::jsonb") else value

    for k in keys:
        data[k] = simple_restructure_to_psql(key=k, value=game.get(k))

    sql = """
            INSERT INTO game ({keys})
            Values({vs})
        """.format(keys=",".join(["period", *jsonb_keys, *keys]), vs=','.join(data.values()))
    return sql
