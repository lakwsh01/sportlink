
import json
import sqlalchemy


db_config = {
    "pool_size": 5,
    "max_overflow": 2,
    "pool_timeout": 30,  # 30 seconds
    "pool_recycle": 60  # 30 minutes
}


def init_tcp_connection_engine(db_config, db_name="sch_public_data"):
    db_user = "postgres"
    db_pass = "12345678"
    ip = "35.200.36.101"
    db_name = db_name
    db_port = 5432

    pool = sqlalchemy.create_engine(
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


try:
    args: dict = {
        # 'id': 'game-a5b5dfc28e794d3d824777539082141a',
        'dt': 1672052300000,
        'district': ["sham_shui_po_district", "yuen_long_district"],
        'game_type': 'badminton',
        'offset': 0,
        'limitation':  {"level": ["hk_7", "hk_5", "hk_6"], "gender": ["male", "all"]}}

    sql: str = None
    if (args and args.get('id')):
        from method.get_game import get_game_at
        sql = get_game_at(id=args['id'])
    else:
        from method.get_game import get_all_game
        sql = get_all_game(dt=args.get('dt'),
                           district=args.get('district'),
                           limitation=args.get('limitation'),
                           game_type=args.get('game_type'),
                           offset=args.get('offset', 0))
    print('sql: ', sql)
    res = public_db_conn.execute(sql)
    for r in res:
        print(dict(r))

except Exception as e:
    print(repr(e))


# SELECT id, game_type, vacancy, (EXTRACT(EPOCH FROM period[1]::timestamp) * 1000)::bigint as expiry, (EXTRACT(EPOCH FROM period[2]::timestamp) * 1000)::bigint as end, venue FROM GAME WHERE period[1] > to_timestamp(1672052300.0) and
# vacancy >= 1 and
# game_type = 'badminton'
#         AND (limited_to -> 'level')::text[] & & ARRAY['hk_6', 'hk_5', 'hk_7']::text[] AND limited_to -> 'gender'::text = 'male' and venue = ANY(Array(Select * from venues)::text[]) offset 0 limit 30
