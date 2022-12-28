import random
from requests import get, post
import json

venues = ['venue-0fde2fa4dd55472385ecbca8212f39c3', 'venue-4dd3ab1574954700b63af7b02f6e4014', 'venue-fe256901af6a4330a9d12a44e2b6b28f', 'venue-c939349a481c41739da0db27155ffdb4', 'venue-271b4b8ac7d844c28bf4e62fbbd0bc43', 'venue-0b33420d82c34258a20150a189236912', 'venue-9f795c49e2d34bf9911e3ddf3b296d7b', 'venue-c5a5474790e743138c1aef73199d5c2e', 'venue-304a32e9a9a04e048d04c33a0670cf1f', 'venue-87c93d4967f94733bd16e2b600bfbd52', 'venue-4c08e1572f794ba79e27b4be1a50000d', 'venue-bef89e1fcfb34b87b2e061e61b73e8ca', 'venue-1a71fb4afc404293b1fc33aba08685b0', 'venue-e7be50cd692f477298b89be9049aee99', 'venue-1be205b018b642899be93bf8d8dba7ca', 'venue-be17b0ecb1a8427cbec506e08874e7b6', 'venue-c82614928e7344888003f4f7cbe1ec16', 'venue-77d2b154193d4f6aadb3bac4162910ef', 'venue-ea257f460ec74b8cbd712bc324c84ac7', 'venue-5d38e5123e45495089942cce238932aa', 'venue-5925437eb5a64f93af9cd110ef8617ea', 'venue-e351328da28f4ce5bffa1bbf2db097a5', 'venue-0f80a19f11ac4eb395a6d445a53b82a2', 'venue-fa669f36f4694dd5ae3427c927728387', 'venue-551985465dbf4eae9ecf525d1519e3f2', 'venue-a76eb929116e4138a46c769e492f0ebc', 'venue-7f353c237fbf45a2b50d7993c3951589', 'venue-3508551c1e0c40649c944d3f7236ea71', 'venue-55dee797398e46c68a62ab35d76b7c45', 'venue-84a5e8650dee4ed4a067eacb3d62eb88', 'venue-177c961040704802b349cbb5a5e50e46', 'venue-091dba671c0342168bba661e3475b570', 'venue-8e3ff3b7e8244990b31468965b4378f0', 'venue-c3cc016bfed545038c80e153e28920ee', 'venue-7f7a23f2e2744055822dcd403d7057da', 'venue-6c1e6a3721fe489595561a4a1f4c00af', 'venue-d16d10263c3645da979826d16fc9d024', 'venue-25b86807d2134a4cad2d9a3b4b51e036', 'venue-347b95ac4a804f97a1494b13e8d52b4d', 'venue-e042c1d6cbfc4c73845f90063478c15b', 'venue-b0fc34820baf408ea00652703403f447', 'venue-525eef813f7841e0b2b66f066310bbd7', 'venue-155ba905720f4ab7ab9780e36580ac78', 'venue-6ff16969bd0345d5aecf7c6cbdc82cc5', 'venue-64d6fdd5d9df4d65ab43fe211cf574fb', 'venue-cf04ce277be340a69519a2e354868109', 'venue-1308b5cbec3c4d659b25f379cc73adbe', 'venue-7962f6a3b9b1476199951adf138f440c', 'venue-4b32bd93ea9149da8bcdee615221e4e2', 'venue-855424ce5c8048e3a01a5256c06ae170', 'venue-a483212e5ea143dcb993ff2408ff6ad6', 'venue-01efa7bda2504e15ac7d992f29567d09', 'venue-892703f4c18d41a592bc1f854f8e8a22', 'venue-dd355afd39bd4df3a1fde7b63a9dd7c1', 'venue-8bef915efd484862a58ff2fd426bd897', 'venue-426fbff1dd2349b0b43395d58d44f30b',
          'venue-c10ff306ac1349d6956ab610506e4a5b', 'venue-5eac5207a4134440976180102df3f485', 'venue-fc5059daff5746569fd22045a877fbd5', 'venue-8a32125d7c7b425d9acd59fca57ed018', 'venue-dd4e1e63b4ae49809d514aa72ba5f3ce', 'venue-a42706c46f464e55b9280cc31646d768', 'venue-9caf7499bd7d4db8a30f10202399c052', 'venue-63f3870ca5404ed7a12e95b6109a2945', 'venue-29c08be35bde4950a246fe0e18321748', 'venue-23212b5719574e5cb9eada3cb2f7a584', 'venue-324f4476d38e4d29b82f0086cdb6e455', 'venue-48ab2a1f07d240488f529f1d4354e080', 'venue-b93f200a6d464ce89713b75d1b48fbef', 'venue-ae801914555d462e994278f589fe01ff', 'venue-f2317e0d8ba144aca3d9bc08dd08ffaf', 'venue-4df65818da3e41ebb238b3cc012ac331', 'venue-14184551e96c472d98577cdbe42c2c5d', 'venue-c38516506137441b93de3f7a2f294208', 'venue-3947244e16e641ffacc614c5c5c3f1da', 'venue-b62e753cf5934f2c9baa50f5283b5a26', 'venue-7ebe7307c4c44a06a9a49142f74c979c', 'venue-fd8f90b12f0c43ea8de7b0065f3d1538', 'venue-cbcc54d2a99545d9a8931092e58b1df8', 'venue-68637be56514481bb1f4f063cae653d3', 'venue-aaf946c93b904a12aef99359fa835c78', 'venue-a4568f16fe4e4f4f8ff472ededff489e', 'venue-cc50b7bbf2ac4a91b558ac00937ca2ff', 'venue-fa54728896e54ecd907dc0165ab3f676', 'venue-71d00d3ef1774197b5888135846efe31', 'venue-30478983d44d4c5bb808210be7f730cd', 'venue-b3e2b7b9a8fd4ca39b3c88f6a71e41e9', 'venue-cde39f4172574a9aa5f92ce93424da1e', 'venue-df150b2585204a98a9ba3f723609db0f', 'venue-5f2a697b095640fe90061e6b830ee68c', 'venue-cb6188ac8e7945d392a28b17934c4a6a', 'venue-9ead6667e5d24ae395e90b9fd25bbce4', 'venue-bd1f330f003343658935f8fd186a111e', 'venue-d8226cfa6b624f5f8863f9eb665c4c46', 'venue-32f1d56fa65342479be8fc4d2ead9d42', 'venue-c812970801584d4280fa64d38a2c5f14', 'venue-f4de0b6a91ae4573865d333f05db4a2a', 'venue-5a98f510aa7748c9adc603e3ca04faf2', 'venue-bf61c50ed8844af5959b3e80498adc5e', 'venue-78a212ca6d3d409da571fa4dd87c82b3', 'venue-52af948b83484d61802ff21746202ec0', 'venue-4b4dc41a5a1747ec99f201572fe049fb', 'venue-47b06aac0e114fb2ac8dcb19271f7dd2', 'venue-22721ba7b05b43d986ddd8a006b94928', 'venue-32792ee767bc468d9cdc72f747e6d5de', 'venue-234b341452884058a5aa06d7e2fbbae2', 'venue-feb2c9a78bce4f6bb3aeaf8b427d7127', 'venue-65795316848f4f67bb139e21656d7f77', 'venue-3d5d094b009d43fbb501dd8473ca6cfd', 'venue-65f0b5cd646644a8ab197942fe833f24', 'venue-e3e9aad3bb614cf5be6e63d0204ad764', 'venue-e4f081b74a684b548fb38ac38e08e232']


def stamp():
    import time
    ss = time.time()
    return int((ss)*1000)


def fields():
    count = random.randint(1, 6)
    l = [i for i in range(100)]
    random.shuffle(l)
    return [l[i] for i in range(count)]


def levels():
    level = [
        "hk_0",
        "hk_1",
        "hk_2",
        "hk_3",
        "hk_4",
        "hk_5",
        "hk_6",
        "hk_7"
    ]
    endidx = len(level) - 1
    start = random.randint(0, endidx)
    end = endidx
    ls: list
    if (start == endidx):
        ls = ["hk_7"]
    else:
        end = random.randint(start, endidx)
        if (end == start):
            ls = [level[start]]
        else:
            ls = level[start:end]
    # print(f"leavel start at : {start}, end at {end} ls: {ls}")
    return ls


gender = ["female", "male", "all"]
reject_report = []


def new_game():
    start = random.randint(-960, 960)
    start = stamp() + (3600000 * start)
    dr = random.randint(2, 6)
    end = start + (3600000 * dr)
    f = fields()
    vacancy = random.randint(1, 9)
    ls = levels()
    li_gender = gender[random.randint(0, 2)]
    venue = random.choice(venues)
    price = random.randint(50, 100)

    game_demo = {
        "permission": {"user": "test_user"},
        "locale_content": {"title": "Game"},
        "assistant": {"auto_reject": False, "auto_confirm": True},
        "game_mode": "double",
        "limited_to": {"gender": li_gender, "level": ls},
        "field": f,
        "price": price,
        "start": start,
        "expiry": end,
        "repeation": None,
        "equipment": {
            "shuttlecock": ["RSL - Superme", "LILING - G200"]},
        "admin": "test_user",
        "vacancy": vacancy,
        "venue": venue,
        "field_rule": "default_rule",
        "game_type": "badminton",
        "max_player_count": 7*len(f)}
    # import datetime
    # print(
    #     f"new game: Field {f} , price: {price}, start: {datetime.datetime.fromtimestamp(start/1000)}, expiry: {datetime.datetime.fromtimestamp(end/1000)}, vacancy: {vacancy}, venue: {venue}, max_player_count: {7*len(f)}")
    return game_demo


# line = 0
# for i in range(250):
#     line += 1
#     g = new_game()

#     url = "https://us-central1-taglayer-99cfc.cloudfunctions.net/sportlink_game/create"
#     res = post(
#         url, headers={'content-type': 'application/json; charset=utf-8', 'Authorization': 'test_user'}, data=json.dumps(g))
#     if (res.status_code != 200):
#         reject_report.append(g)
#         print(f"status : ${res.status_code} ::: {res.json()}")
#     print(f"line :{line} complete")

# if (reject_report):
#     with open("reject_report.json", mode='w', encoding='utf-8') as jsonfy:
#         jsonfy.write(json.dumps(reject_report))
# print("batch insert done")
