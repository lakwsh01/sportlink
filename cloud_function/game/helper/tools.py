
import uuid
import time
import sqlalchemy


database_url = "https://sportlink-45001-default-rtdb.firebaseio.com/"


def get_public_sql_db(database: str = "sportlink_public"):
    connection_name = "taglayer-99cfc:asia-northeast1:sch-public-service-instance"
    db_user = "postgres"
    db_password = "12345678"
    driver_name = 'postgresql+pg8000'

    query_string = dict(
        {"unix_sock": "/cloudsql/{}/.s.PGSQL.5432".format(connection_name)})
    return sqlalchemy.create_engine(
        sqlalchemy.engine.url.URL(
            drivername=driver_name,
            username=db_user,
            password=db_password,
            database=database,
            query=query_string),
        pool_size=5,
        max_overflow=2,
        pool_timeout=30,
        pool_recycle=90)


def id_builder(initial: str = None):
    new_uuid = (str(uuid.uuid4())).replace("-", "")
    if (initial):
        return f"{initial}_" + new_uuid
    else:
        return new_uuid


def stamp():
    ss = time.time()
    return int((ss)*1000)


# def place_permission_check(app: App, sid: str, siden: str):
#     db_ref = db.reference(path=f"service/place_management_permission/{siden}/{sid}", app=app,
#                           url="https://scorch-config.firebaseio.com")
#     data: dict = db_ref.get()
#     if(data):
#         role = data.get('role')
#         if(role == "00"):
#             # print(f"role {role} get for {siden} :: user {sid}")
#             return True
#         else:
#             return False
#     else:
#         return False
