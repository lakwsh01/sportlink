
import json

from helper.content_restructure import dict_to_json, dt_to_psql_timestamp, simple_restructure_to_psql

from sqlalchemy import engine


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


def create_demo_game(db_conn: engine.Connection, length: int = 100, bounced_report_path="database/output/error/reject_report.json"):
    reject_report = []
    line = 0
    from demo_builder.game import new_game
    for i in range(length):
        line += 1
        g = new_game()
        try:
            sql = sql_insert_to_game(g)
            db_conn.execute(sql)
            print(f"line {line} completed")
        except Exception as e:
            reject_report.append({
                "sql": sql,
                "error": repr(e),
                "data": g,
                "line": line})
            print(f"line {line} is errored")
    if (reject_report):
        with open(bounced_report_path, mode='w', encoding='utf-8') as jsonfy:
            jsonfy.write(json.dumps(reject_report))
    print("batch insert done")
