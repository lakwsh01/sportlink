
import sqlalchemy
#  game-40b98f6f70a04b0db329119bfaa8b4e2 | venue-5f2a697b095640fe90061e6b830ee68c |       9
#  game-1fba6df226544edebd00bb44a276f74d | venue-fc5059daff5746569fd22045a877fbd5 |       9
#  game-8bb1a375478544f399e2b8b6781365dc | venue-1be205b018b642899be93bf8d8dba7ca |       9
#  game-760a97d999b54c7eb41ee773d45c6f63 | venue-fa54728896e54ecd907dc0165ab3f676 |       9
#  game-383736c0afc24eb4989a97652669b62f | venue-324f4476d38e4d29b82f0086cdb6e455 |       9
#  game-6f53209d724c4d15911bebf973b1c8e1 | venue-7f7a23f2e2744055822dcd403d7057da |       9
#  game-8b369424935441998d7e875c08d983cc | venue-6ff16969bd0345d5aecf7c6cbdc82cc5 |       9
#  game-564baa1b697b4c61b8ca8508eb041cda | venue-4b32bd93ea9149da8bcdee615221e4e2 |       9
#  game-454f79677d10467a96b806b8f7527eb2 | venue-855424ce5c8048e3a01a5256c06ae170 |       9
#  game-20568094f98f42ea97eb81eaf9023087 | venue-4df65818da3e41ebb238b3cc012ac331 |       9
#  game-488820c48b214ed5b9a7b00c4da5cfe6 | venue-dd355afd39bd4df3a1fde7b63a9dd7c1 |       9
#  game-36d16d259af64f5aaba32ffe4d9e1421 | venue-bf61c50ed8844af5959b3e80498adc5e |       9


locale = "zh_HK"
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
    target_user = "test_user_profile_id"
    args: dict = {
        'game': 'game-40b98f6f70a04b0db329119bfaa8b4e2',
        'target_user': target_user}
    sql: str = None
    from method.create_application import sql_insert_to_application
    from method.get_application import sql_application_at
    sql = sql_application_at(game_id='game-40b98f6f70a04b0db329119bfaa8b4e2')
    print(sql)
    res = list(public_db_conn.execute(sql))
    for r in res:
        print(dict(r))

except Exception as e:
    print(repr(e))


# SELECT id, game_type, vacancy, (EXTRACT(EPOCH FROM period[1]::timestamp) * 1000)::bigint as expiry, (EXTRACT(EPOCH FROM period[2]::timestamp) * 1000)::bigint as end, venue FROM GAME WHERE period[1] > to_timestamp(1672052300.0) and
# vacancy >= 1 and
# game_type = 'badminton'
#         AND (limited_to -> 'level')::text[] & & ARRAY['hk_6', 'hk_5', 'hk_7']::text[] AND limited_to -> 'gender'::text = 'male' and venue = ANY(Array(Select * from venues)::text[]) offset 0 limit 30
