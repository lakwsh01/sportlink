from werkzeug import Request, Response
from json import loads


def post_event_body_decoder(request: Request):
    content_type = request.headers['content-type']
    if request.data:
        if content_type == 'application/json; charset=utf-8':
            content: dict = loads(request.data)
            return content
        else:
            raise ValueError({"invaild content-type": content_type,
                              "message": "The API currently handle 'application/json; charset=utf-8' content only for POST method"})
    else:
        raise ValueError({"invaild content-type": content_type,
                          "message": "The API currently handle 'application/json; charset=utf-8' content only for POST method"})


def get_event_body_decoder(request: Request):
    return dict(request.args)
