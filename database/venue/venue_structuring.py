
# venue_response_db_structure = {
#     "address": "Sai Kung Squash Court And Tennis Court, 10 , Sai Kung, Hong Kong",
#     "name": "Sai Kung Squash Court And Tennis Court",
#     "area": {
#         "country": "HKG",
#         "district": "w",
#         "province": "",
#         "zone": ""
#     },
#     "description": None,
#     "facilities": None,
#     "geog": [0, 1],
#     "source": {"gpid": "ChIJkWCJIJgFBDQREZRArq1sHt0",
#                "spid": "spid"
#                },
#     "coming_games": {
#         "badminton": {
#             "games_count": 10,
#             "totla_vacancy": 20,
#             "coming_first": {
#                 "dt": 091234,
#                 "id": "1234"
#             }
#         }
#     }
# }


import json


def venue_standard_respone_builder(venue_id: str, venue: dict):
    import uuid
    spid = str(uuid.uuid4())
    gpid = venue_id
    venue_address = venue["zh_hk"]["formatted_address"]
    venue_name = venue["zh_hk"]["name"]
    area = {
        "country": venue["sportlink"]["country"],
        "district": venue["sportlink"]["district"],
        "province": venue["sportlink"]["province"],
        "zone": venue["sportlink"]["zone"]
    }
    source = {"google_place_sdk": gpid}
    coming_games = {
        "badminton": {
            "games_count": 10,
            "totla_vacancy": 20,
            "coming_first": {
                "dt": 901353815,
                "id": "1234"
            }
        }
    }

    response = {
        "description": None,
        "facilities": None,
        "coming_games": coming_games,
        "source": source,
        "division": area,
        "address": venue_address,
        "name": venue_name,
        "id": spid,
        "geog": [venue["en_us"]["geometry"]["location"]["lat"], venue["en_us"]["geometry"]["location"]["lng"]]
    }
    return response


source_data: dict
venues_json = []
with open(f"database/output/venues.json", mode="r", encoding="utf-8") as jsonfy:
    source_data = json.loads(jsonfy.read())


for k, v in source_data.items():
    data = venue_standard_respone_builder(venue_id=k, venue=v)
    venues_json.append(data)


with open(f"database/output/venues_response.json", mode="w", encoding="utf-8") as jsonfy:
    jsonfy.write(json.dumps(venues_json))
