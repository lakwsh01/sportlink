from demo_game_builder import create_demo_game
from venue.game_structuring import sql_insert_to_game
from venue.venue_structuring import sql_venue_to_database, build_venues_output
import json
import sqlalchemy

from helper.tools import stamp


db_config = {
    # [START cloud_sql_postgres_sqlalchemy_limit]
    # Pool size is the maximum number of permanent connections to keep.
    "pool_size": 5,
    # Temporarily exceeds the set pool_size if no connections are available.
    "max_overflow": 2,
    # The total number of concurrent connections for your application will be
    # a total of pool_size and max_overflow.
    # [END cloud_sql_postgres_sqlalchemy_limit]

    # [START cloud_sql_postgres_sqlalchemy_backoff]
    # SQLAlchemy automatically uses delays between failed connection attempts,
    # but provides no arguments for configuration.
    # [END cloud_sql_postgres_sqlalchemy_backoff]

    # [START cloud_sql_postgres_sqlalchemy_timeout]
    # 'pool_timeout' is the maximum number of seconds to wait when retrieving a
    # new connection from the pool. After the specified amount of time, an
    # exception will be thrown.
    "pool_timeout": 30,  # 30 seconds
    # [END cloud_sql_postgres_sqlalchemy_timeout]

    # [START cloud_sql_postgres_sqlalchemy_lifetime]
    # 'pool_recycle' is the maximum number of seconds a connection can persist.
    # Connections that live longer than the specified amount of time will be
    # reestablished
    "pool_recycle": 1800,  # 30 minutes
    # [END cloud_sql_postgres_sqlalchemy_lifetime]
}


def init_tcp_connection_engine(db_config, db_name="sch_public_data"):
    # [START cloud_sql_postgres_sqlalchemy_create_tcp]
    # Remember - storing secrets in plaintext is potentially unsafe. Consider using
    # something like https://cloud.google.com/secret-manager/docs/overview to help keep
    # secrets secret.

    db_user = "postgres"
    db_pass = "12345678"
    ip = "35.200.36.101"
    # db_name = "sch_public_data"
    db_name = db_name
    # Extract host and port from db_host
    db_port = 5432

    pool = sqlalchemy.create_engine(
        # Equivalent URL:
        # postgresql+pg8000://<db_user>:<db_pass>@<db_host>:<db_port>/<db_name>
        sqlalchemy.engine.url.URL.create(
            drivername="postgresql+pg8000",
            username=db_user,  # e.g. "my-database-user"
            password=db_pass,  # e.g. "my-database-password"
            host=ip,  # e.g. "127.0.0.1"
            port=db_port,  # e.g. 5432
            database=db_name  # e.g. "my-database-name"
        ),
        **db_config
    )
    # [END cloud_sql_postgres_sqlalchemy_create_tcp]
    pool.dialect.description_encoding = None
    return pool


public_db = init_tcp_connection_engine(db_config, db_name="sportlink_public")
public_db_conn = public_db.connect()


def query(conn: sqlalchemy.engine.Connection, sql: str, id_key: str = None, offset: int = 0, limit: int = None):
    try:
        res = conn.execute(sql)

        if (id_key):
            data = dict()
            line = offset
            for row in res:
                dict_row = dict(row)
                id = dict_row[id_key]
                dict_row["order"] = line
                data[id] = dict_row
                line += 1
                print(line, " ", id)
        else:
            data = [dict(row) for row in res]
            for k in data:
                print(k)
            line = offset + len(data)
            # print(data)

        result = {
            "results": data,
            "count": line,
            "meedend": True if (line < limit if limit else False) else True
        }

        path = "database/test_result/query/"
        md = stamp()
        with open(f"{path}{md}.json", mode='w', encoding="utf-8") as jsonfy:
            jsonfy.write(json.dumps(result))
        return result

    except Exception as e:
        print("exception : ", repr(e))
        raise e


# q = query(conn=public_db_conn, sql="SELECT * FROM venue", id_key="id")
# print(q)
# build_venues_output()
# with open("database/output/venues_response.json", mode="r", encoding="utf-8") as jsonfy:
#     content = json.loads(jsonfy.read())
#     sql = sql_venue_to_database(content)
#     print(sql)

# game_demo = {
#     "permission": {"user": "test_user"},
#     "locale_content": {"title": "Game"},
#     "assistant": {"auto_reject": False, "auto_confirm": True},
#     "game_mode": "double",
#     "limited_to": {"gender": "female", "level": ["hk_3", "hk_4"]},
#     "field": ["v", "f"],
#     "price": 50.0,
#     "period": {"start": 1672052400000, "expiry": 1672059600000},
#     "repeation": None,
#     "equipment": {
#         "shuttlecock": ["RSL - Superme", "LILING - G200"]},
#     "admin": "test_user",
#     "vacancy": 9,
#     "venue": "venue-0b33420d82c34258a20150a189236912",
#     "field_rule": "default_rule",
#              "game_type": "badminton",
#              "max_player_count": 25}

# sql = sql_insert_to_game(game=game_demo)

create_demo_game(db_conn=public_db_conn, length=4000)
