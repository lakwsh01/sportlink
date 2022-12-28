
from sqlalchemy import engine
import json
from json import dumps
from flask import Flask
from flask_cors import cross_origin
from werkzeug import Request, Response
from firebase_admin import credentials, initialize_app
from helper.body_decoder import post_event_body_decoder
from helper.tools import get_public_sql_db


app = Flask(__name__)

cred = credentials.Certificate("helper/firebase_cred.json")
initialize_app(cred)


@app.route("/", methods=['POST', 'GET'])
@cross_origin()
def main(request: Request):
    print("function start")
    # jwt = request.headers['Authorization']
    db_config = get_public_sql_db()
    db: engine.Connection = db_config.connect()

    request_method = request.method
    request_path = request.path
    print("request: method ", request_method, " path: ", request_path)
    args: dict

    response = Response(dumps({
        "error":
        {"code": "inhibited_request_method",
         "message": f"Invalid request method {request_method} for the sdk ",
         "detail": f"The request method : {request_method} is not a valid method for the sdk"
         }}), status=500)

    try:
        args = dict(request.args) if request_method == "GET" else post_event_body_decoder(
            request=request)
        # uid = get_user_by_jwt(jwt=jwt, firebaseApp=firebaseApp)

        if (request_method == "GET" and request_path == "/all"):
            geog: list = [float(i) for i in args.get("geog").split(',')]
            offset: int = args.get("offset", 0)
            sql: str
            from method.get_venue import get_all_venue
            sql = get_all_venue(geog=geog, offset=offset,
                                locale=args.get('locale', 'zh_HK'))
            res = db.execute(sql)
            venues = [dict(r) for r in res]
            response = Response(json.dumps(venues), status=200,
                                content_type="application/json; charset=utf-8")

        elif (request_method == "GET" and request_path == "/near_by"):
            geog: list = [float(i) for i in args.get("geog").split(',')]
            sql: str
            from method.get_venue import get_venue_nearby
            sql = get_venue_nearby(geog=geog,
                                   locale=args.get('locale', 'zh_HK'))
            res = db.execute(sql)
            venues = [dict(r) for r in res]
            response = Response(json.dumps(venues), status=200,
                                content_type="application/json; charset=utf-8")
        elif (request_method == "GET" and "/district" in request_path):
            from method.get_venue import get_venue_at_district
            district = request_path.split('/')[-1]
            sql = get_venue_at_district(
                district=district, locale=args.get('locale', 'zh_HK'))
            res = db.execute(sql)
            venues = [dict(r) for r in res]
            response = Response(json.dumps(venues), status=200,
                                content_type="application/json; charset=utf-8")

        elif (request_method == "GET" and request_path == "/venue" and args.get('id')):
            from method.get_venue import get_venue_at
            sql = get_venue_at(id=args.get(
                'id'), locale=args.get('locale', 'zh_HK'))
            res = db.execute(sql)
            venues = dict(res[0])
            response = Response(json.dumps(venues), status=200,
                                content_type="application/json; charset=utf-8")

    except Exception as e:
        return Response(json.dumps(
            {"error": {
                "code": "????",
                "message": repr(e),
            }}), status=500, content_type="application/json; charset=utf-8")

    return response
