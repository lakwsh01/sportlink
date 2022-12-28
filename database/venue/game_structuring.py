

from helper.content_restructure import dict_to_json, dt_to_psql_timestamp, simple_restructure_to_psql


def sql_insert_to_game(game: dict):
    keys = [
        "title", "description", "game_mode", "field", "price", "repeation",
        "vacancy", "field_rule", "game_type", "max_player_count", "venue"
    ]
    jsonb_keys = ["permission", "equipment", "assistant", "limited_to"]
    period_start = game["period"]["start"]
    period_expiry = game["period"]["expiry"]
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

# id | character varying(255) | | |
# title | hstore | | |
# description | hstore | | |
# assistant | jsonb | | not null |
# game_mode | character varying(255) | | not null |
# limited_to | jsonb | | not null |
# field | character varying[] | | not null |
# price | real | | not null |
# period | timestamp without time zone[] | | not null |
# repeation | jsonb | | |
# equipment | jsonb | | not null |
# permission | jsonb | | not null |
# vacancy | integer | | not null |
# field_rule | character varying(255) | | not null |
# game_type | character varying(255) | | not null |
# max_player_count | integer | | not null |
# venue | character varying(255) | | not null |
# row              | integer                       |           | not null | nextval('game_row_seq':: regclass)
