import csv
import json


def district_builder():
    csvpath = "database/source/sportlink - district.csv"
    districts = []
    line_count = 0
    with open(csvpath, mode='r', encoding='utf-8') as venues:
        spam = csv.reader(venues, delimiter=",")
        for i in spam:
            if(line_count == 0):
                line_count += 1
            else:
                # country,province,zone,district_code,zh,en
                # hk,hk,hki,central_and_western_district,中西區,Central and western district
                country = i[0]
                province = i[1]
                zone = i[2]
                district_code = i[3]
                zh = i[4]
                en = i[5]
                district = {
                    "country": country,
                    "province": province,
                    "zone": zone,
                    "code": district_code,
                    "locale": {
                        "zh": zh,
                        "en": en
                    }
                }
                districts.append(district)
                # print(i, " in line ", line_count, " complete")
                line_count += 1

    with open(f"database/output/districts.json", mode="w", encoding="utf-8") as jsonfy:
        jsonfy.write(json.dumps(districts))


def district_builder():
    csvpath = "database/source/sportlink - district.csv"
    districts = []
    line_count = 0
    with open(csvpath, mode='r', encoding='utf-8') as venues:
        spam = csv.reader(venues, delimiter=",")
        for i in spam:
            if(line_count == 0):
                line_count += 1
            else:
                # country,province,zone,district_code,zh,en
                # hk,hk,hki,central_and_western_district,中西區,Central and western district
                country = i[0]
                province = i[1]
                zone = i[2]
                district_code = i[3]
                zh = i[4]
                en = i[5]
                district = {
                    "country": country,
                    "province": province,
                    "zone": zone,
                    "code": district_code,
                    "locale": {
                        "zh": zh,
                        "en": en
                    }
                }
                districts.append(district)
                # print(i, " in line ", line_count, " complete")
                line_count += 1

    with open(f"database/output/districts.json", mode="w", encoding="utf-8") as jsonfy:
        jsonfy.write(json.dumps(districts))


def zone_builder():
    csvpath = "database/source/sportlink - zone.csv"
    zones = []
    line_count = 0
    with open(csvpath, mode='r', encoding='utf-8') as venues:
        spam = csv.reader(venues, delimiter=",")
        for i in spam:
            if(line_count == 0):
                line_count += 1
            else:
                # country,province,zone,zh,en
                country = i[0]
                province = i[1]
                zone_code = i[2]
                zh = i[3]
                en = i[4]
                zone = {
                    "country": country,
                    "province": province,
                    "code": zone_code,
                    "locale": {
                        "zh": zh,
                        "en": en
                    }
                }
                zones.append(zone)
                # print(i, " in line ", line_count, " complete")
                line_count += 1

    with open(f"database/output/zones_hk.json", mode="w", encoding="utf-8") as jsonfy:
        jsonfy.write(json.dumps(zones))


zone_builder()
