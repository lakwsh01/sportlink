from firebase_admin import auth


def authenticate_with_token(id_token: str):
    auth_report = auth.verify_id_token(id_token=id_token)
    uid = auth_report['uid']
    return uid
