
from json import loads
from urllib.parse import urlparse
from urllib.request import Request
import uuid
from firebase_admin import db, auth, App
import time


def authenticate_with_token(id_token: str,  app: App):
    auth_report = auth.verify_id_token(id_token=id_token, app=app)
    uid = auth_report['uid']
    return uid


def id_builder(initial: str = None):
    new_uuid = (str(uuid.uuid4())).replace("-", "")
    if(initial):
        return f"{initial}_" + new_uuid
    else:
        return new_uuid


def stamp():
    ss = time.time()
    return int((ss)*1000)


def post_event_body_decoder(request):
    uri = urlparse(request.url)
    content_type = request.headers['content-type']
    if content_type == 'application/json; charset=utf-8':
        queryparam: dict = loads(request.data)
        return uri.path, queryparam
    else:
        raise ValueError({"invaild content-type": content_type,
                          "message": "The API currently handle 'application/json; charset=utf-8' content only for POST method"})


def get_event_body_decoder(request: Request):
    content_type = request.headers['content-type']
    if request.args:
        arg = dict(request.args)
        return arg
    else:
        raise ValueError({"invaild content-type": content_type,
                          "message": "The API currently handle 'application/json; charset=utf-8' content only for POST method"})


def place_permission_check(app: App, sid: str, siden: str):
    db_ref = db.reference(path=f"service/place_management_permission/{siden}/{sid}", app=app,
                          url="https://scorch-config.firebaseio.com")
    data: dict = db_ref.get()
    if(data):
        role = data.get('role')
        if(role == "00"):
            # print(f"role {role} get for {siden} :: user {sid}")
            return True
        else:
            return False
    else:
        return False
