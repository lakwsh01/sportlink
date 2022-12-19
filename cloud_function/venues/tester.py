from requests import get, post

url = "https://us-central1-sportlink-372009.cloudfunctions.net/venues/all"
res: list = get(
    url, headers={'content-type': 'application/json; charset=utf-8'}).json()

line = 0
for item in res:
    line += 1
    print(item['name'], " line ", line)
