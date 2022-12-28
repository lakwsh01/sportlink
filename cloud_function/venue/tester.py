from requests import get, post

url = "https://us-central1-taglayer-99cfc.cloudfunctions.net/sportlink_venue/district/kwun_tong_district"
res = get(
    url, headers={'content-type': 'application/json; charset=utf-8'}).json()


# datas = list(res)
# for d in datas:
#     print(d['name'])
# print('totle: ', len(res))

print(res)
