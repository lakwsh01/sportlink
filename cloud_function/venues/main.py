
import json
from json import dumps
from flask import Flask
from flask_cors import cross_origin
from werkzeug import Request, Response
from firebase_admin import credentials, initialize_app, App as FirebaseApp, firestore
from tools.body_decoder import get_event_body_decoder, post_event_body_decoder
# from helper.tools import authenticate_with_token,  post_event_body_decoder

app = Flask(__name__)

cred = credentials.Certificate("tools/firebase_cred.json")
initialize_app(cred)


@app.route("/", methods=['POST', 'GET'])
@cross_origin()
def main(request: Request):
    print("function start")
    # jwt = request.headers['Authorization']
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
        args = get_event_body_decoder(
            request=request) if request_method == "GET" else post_event_body_decoder(request=request)
        # uid = get_user_by_jwt(jwt=jwt, firebaseApp=firebaseApp)

        print("request: method ", request_method,
              " path: ", request_path, " args: ", args)
        if(request_method == "GET" and request_path == "/all"):
            from method.get_venues.venues_all import get_available_venues
            print("start to get venues")
            venues = get_available_venues()
            print("venues: ", venues)
            response = Response(json.dumps(venues), status=200,
                                content_type="application/json; charset=utf-8")

    except Exception as e:
        return Response(json.dumps(
            {"error": {
                "code": "????",
                "message": repr(e),
            }}), status=500, content_type="application/json; charset=utf-8")

    return response
