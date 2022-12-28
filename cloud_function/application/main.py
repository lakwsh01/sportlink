from helper.body_decoder import get_event_body_decoder, post_event_body_decoder
from firebase_admin import credentials, initialize_app
from werkzeug import Request, Response
from flask_cors import cross_origin
from flask import Flask
from json import dumps
from helper.tools import get_public_sql_db
from helper.auth import authenticate_with_token
from sqlalchemy import engine
app = Flask(__name__)

cred = credentials.Certificate("helper/firebase_cred.json")
initialize_app(cred)
locale = "zh_HK"


@app.route("/", methods=['POST', 'GET'])
@cross_origin()
def main(request: Request):
    request_method = request.method
    uid: str
    db_config = get_public_sql_db()
    db: engine.Connection = db_config.connect()
    # print("function start")
    request_method = request.method
    request_path = request.path
    jwt = request.headers['Authorization']
    # uid = authenticate_with_token(jwt)
    # print("request: method ", request_method, " path: ", request_path)
    args: dict
    response = Response(dumps({
        "error":
        {"code": "inhibited_request_method",
         "message": f"Invalid request method {request_method} for the sdk ",
         "detail": f"The request method : {request_method} is not a valid method for the sdk"
         }}), status=500)

    try:
        args = get_event_body_decoder(
            request=request) if request_method == "GET" else post_event_body_decoder(request=request)
        # uid = get_user_by_jwt(jwt=jwt, firebaseApp=firebaseApp)

        print("request: method ", request_method,
              " path: ", request_path, " args: ", args)
        if (request_method == "POST" and "/submit" in request_path):
            # auth required
            sql: str = None
            from method.create_application import sql_insert_to_application
            sql = sql_insert_to_application(app=args)
            res = list(db.execute(sql))[0]
            if (res):
                return Response(dict(res), status=200, content_type="application/json; charset=utf-8")
            else:
                return Response(status=500, content_type="application/json; charset=utf-8")
        elif (request_method == "GET" and "/application/game" in request_path):
            game_id = request_path.split('/')[-1]
            sql: str
            if (args and args.get('id')):
                from method.create_application import get_game_at
                sql = get_game_at(id=id)
            else:
                from method.get_game import get_all_game
                sql = get_all_game
            res = db.execute(sql)
            return Response(dumps(res), status=200, content_type="application/json; charset=utf-8")

    except Exception as e:
        return Response(dumps(
            {"error": {
                "code": "????",
                "message": repr(e),
            }}), status=500, content_type="application/json; charset=utf-8")

    return response
