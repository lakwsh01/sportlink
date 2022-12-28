
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


import helper.content_restructure as c
import json


def venue_standard_respone_builder(venue_id: str, venue: dict):
    import uuid
    spid = str(uuid.uuid4())
    gpid = venue_id
    area = {
        "country": venue["sportlink"]["country"],
        "district": venue["sportlink"]["district"],
        "province": venue["sportlink"]["province"] if (venue["sportlink"]["province"]) else None,
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
        "name": {
            "zh_HK": venue["zh_hk"]["name"],
            "zh_TW": venue["zh_tw"]["name"],
            "en": venue["en_us"]["name"]},
        "address": {
            "zh_HK": venue["zh_hk"]["formatted_address"],
            "zh_TW": venue["zh_tw"]["formatted_address"],
            "en": venue["en_us"]["formatted_address"]},
        "description": {},
        "facilities": [],
        "coming_games": coming_games,
        "source": source,
        "division": area,
        "geog": [venue["en_us"]["geometry"]["location"]["lat"], venue["en_us"]["geometry"]["location"]["lng"]],
        "id": spid
    }
    return response


def build_venues_output(source_data_link: str = "database/output/venues.json"):
    source_data: dict
    venues_json = []
    with open(source_data_link, mode="r", encoding="utf-8") as jsonfy:
        source_data = json.loads(jsonfy.read())

    for k, v in source_data.items():
        data = venue_standard_respone_builder(venue_id=k, venue=v)
        venues_json.append(data)

    with open(f"database/output/venues_response.json", mode="w", encoding="utf-8") as jsonfy:
        jsonfy.write(json.dumps(venues_json))


def sql_venue_to_database(venues: list):
    keys = ["geog", "division",
            "source", "description", "address", "name"]
    values: list[dict[str, str]] = []
    v: dict
    for v in venues:
        sql_data: dict = {}
        for key in keys:
            # print(key, " ", v.get(key))
            sql_data[key] = c.simple_restructure_to_psql(
                key=key, value=v.get(key))
        values.append(sql_data)

    # sql = """
    #         INSERT INTO venue ({keys})
    #         {values}
    #     """.format(keys=",".join(keys), values="Values({})".format(
    #     ','.join('({})'.format(','.join(v.values())) for v in values)))

    values_line: list[str] = ['('+','.join(v.values())+')' for v in values]

    sql = """
            INSERT INTO venue ({keys})
            Values{vs}
        """.format(keys=",".join(keys), vs=','.join(values_line))
    return sql
