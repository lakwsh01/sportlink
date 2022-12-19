from firebase_admin import db, App
from tools.static import database_url


def get_available_venues():
    ref = db.reference(path="/public/venues", url=database_url)
    return ref.get()
