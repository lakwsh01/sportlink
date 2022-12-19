from os import path
from uuid import uuid4
from pathlib import Path
from requests import get as rget
import json
import csv

rootAttributeSeperator = "&"
rootParamRegKey: str = "{id}"
rootParamSessiontoken = "sessiontoken={id}"
rootDetailEndPoint = "https://maps.googleapis.com/maps/api/place/details/json?"
rootParamPlaceId = "place_id={id}"
rootParamLang = "language={id}"
rootParamField = "fields={id}"
rootKey = "key={id}"
fieldFull: str = f"fields=name,geometry,formatted_address,types,formatted_phone_number,price_level,website,rating,user_ratings_total,opening_hours"
fieldMin: str = f"fields=name,formatted_address"


def place_mg_from_google(pid: str):
    uid4: str = str(uuid4())
    uid4 = uid4.replace('-', '')
    raw: dict = _rawGetter(pid)
    if(raw['zh_tw'] and raw['zh_hk'] and raw['en_us']):
        return raw
    else:
        raise Exception("place_not_found_from_google")


def _rawGetter(pid: str):
    api_key, sessionToken = "AIzaSyAooejD34hdQLAYoOd3WwtnRq0kJe-lzA4", None
    place: dict = dict()
    _rootKey: str = rootKey
    _rootParamPlaceId = rootParamPlaceId.replace(
        rootParamRegKey, pid)
    if(sessionToken is not None):
        _rootKey = _rootKey.replace(
            rootParamRegKey, api_key,

            # getKey(keyType="google_place_api/autocomplete")
        )
        _rootParamSessiontoken = rootParamSessiontoken.replace(
            rootParamRegKey, sessionToken)
        place["en_us"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'en'), fieldFull,_rootParamSessiontoken,_rootKey])}").json().get("result")
        place["zh_tw"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'zh_tw'), fieldMin,_rootParamSessiontoken,_rootKey])}").json().get("result")
        place["zh_hk"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'zh_hk'), fieldMin,_rootParamSessiontoken,_rootKey])}").json().get("result")

        return place
    else:
        _rootKey = _rootKey.replace(
            rootParamRegKey, api_key
            # getKey(keyType="google_place_api/place_detail")
        )
        place["en_us"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'en'), fieldFull,_rootKey])}").json().get("result")
        place["zh_tw"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'zh_tw'), fieldMin,_rootKey])}").json().get("result")
        place["zh_hk"] = rget(
            f"{rootDetailEndPoint}{rootAttributeSeperator.join([_rootParamPlaceId,rootParamLang.replace(rootParamRegKey,'zh_hk'), fieldMin,_rootKey])}").json().get("result")

        return place


# place =
csvpath = "database/source/sportlink - venue.csv"
venues_json = {}
line_count = 0
with open(csvpath, mode='r', encoding='utf-8') as venues:
    spam = csv.reader(venues, delimiter=",")
    for i in spam:
        if(line_count == 0):
            line_count += 1
        else:
            name = i[0]
            gpid = i[1]
            country = i[2]
            province = i[3]
            zone = i[4]
            district = i[6]
            venue_source = {
                "name": name,
                "gpid": gpid,
                "country": country,
                "province": province,
                "zone": zone,
                "district": district
            }
            place_detail = place_mg_from_google(pid=gpid)
            place_detail["sportlink"] = venue_source
            venues_json[gpid] = place_detail
            print(gpid, " in line ", line_count, " complete")
            line_count += 1


with open(f"database/output/venues.json", mode="w", encoding="utf-8") as jsonfy:
    jsonfy.write(json.dumps(venues_json))


# def get_google_api_key(firebaseApp: App, keyType="autocomplete"):
#     db_ref = db.reference(app=firebaseApp,
#                           url="https://api-supplementary.firebaseio.com/", path=f"google_place_api/api_key/{keyType}")
#     query = db_ref.order_by_child("try_count").end_at(
#         9999).limit_to_first(1).get()
#     if(query):
#         api_key, key_detail = list(query.items())[0]
#         try_count = key_detail["try_count"]
#         db_ref.child(api_key).child("try_count").set(try_count+1)
#         const_s_token = key_detail["const_session_token"]
#         return str(api_key), const_s_token
#     else:
#         return None


# def fb_id_getter(url: str):
#     # https://www.facebook.com/scroch.map/
#     _url: str = url.lower()
#     if("facebook" in _url):
#         lines: list(str) = _url.split("facebook.com/")
#         return (lines[1].split('/'))[0]
#     else:
#         return None


# # AttributeError("'NoneType' object has no attribute 'get'")
# def restructure_to_psql(pid: str, raw: dict, siden: str, regions: dict):
#     # print(f"restructure_to_psql start at {pid}", " with raw content ", raw)
#     place: dict = dict()
#     primaryAddress: str = raw["en_us"].get("formatted_address")

#     # print(f"primaryAddress get at {pid}")
## region: str = region_getter(address=primaryAddress, regions=regions)

#     # print(f"raw region_getter passed at {pid}")
#     types = raw["en_us"].get("types")
#     types_dict: dict = {a: None for a in types}
#     place["types"] = dict_to_hstore(data=types_dict)

#     place["name"] = dict_to_hstore(data={"zh_tw": raw["zh_tw"].get("name"), "zh_hk": raw["zh_hk"].get(
#         "name"), "en_us": raw["en_us"].get("name")})
#     place["address"] = dict_to_hstore({"zh_tw": raw["zh_tw"].get("formatted_address"), "zh_hk": raw["zh_hk"].get(
#         "formatted_address"), "en_us": primaryAddress})

#     place["location"] = location_builder(
#         lat=raw["en_us"]["geometry"]["location"]["lat"], lng=raw["en_us"]["geometry"]["location"]["lng"])
#     place["region"] = string_to_psql_string(string=region)

#     # print(f"raw getter passed at {pid}")
#     # details
#     from json import dumps
#     opening_hours = dumps(opening_hour_from_google_to_v10(raw["en_us"].get(
#         "opening_hours", {}).get("periods"))) if "opening_hours" in raw["en_us"] else None

#     place["opening_hours"] = '{}'.format(
#         f'\'{opening_hours}\'' if opening_hours else 'NULL')
#     place["price_level"] = '{}'.format(raw["en_us"].get('price_level', 'NULL'))
#     rate = dumps(
#         {"google": {raw["en_us"].get("rating"): raw["en_us"].get('user_ratings_total')}}) if 'rating' in raw["en_us"] and 'user_ratings_total' in raw["en_us"] else None
#     place["rate"] = '{}'.format(f'\'{rate}\'' if rate else 'NULL')

#     # print(f"opening_hours ::: {opening_hours} ")
#     # print(f"rate ::: {rate} ")
#     # agents
#     website: str = raw["en_us"].get("website")
#     if (website is not None) and ("facebook.com" in website):
#         raw["en_us"]["facebook"] = fb_id_getter(website)
#         raw["en_us"]["website"] = None

#     place["agents"] = dict_to_hstore(data={
#         "e-mail": None,
#         "facebook": None,
#         "instagram": None,
#         "line": None,
#         "twitter": None,
#         "phone": raw["en_us"].get("formatted_phone_number"),
#         "website": raw["en_us"].get("website"),
#         "google_place_api": pid,
#         "scorch_place_iden": siden
#     })
#     place['siden'] = string_to_psql_string(siden)

#     cd = dt_to_psql_timestamp()
#     place["creation"] = cd
#     place["md"] = cd

#     # place["certificate"] = dict()
#     # print(f'structured place: {place}')

#     place["batch_import_tag"] = string_to_psql_string(string="unit")

#     return place


# def region_getter(address: str, regions: dict):
#     for key, value in regions.items():
#         tags = value.get("search_tags")
#         for tag in tags:
#             if(tag in address):
#                 return key

#     return None


# def opening_hour_from_google_to_v10(schedule: list):
#     res_list = []
#     for s in schedule:
#         open_d = s['open']['day']
#         open_t = dt_builder(s['open']['time'])

#         close_d = s.get('close', {}).get('day')
#         ct = s.get('close', {}).get('time')
#         close_t = dt_builder(ct) if ct else None

#         res_list.append({'close_d': close_d,
#                          'open_d': open_d,
#                          'open_t': open_t,
#                          'close_t': close_t})
#     return res_list
