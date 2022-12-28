from requests import get, post
import json

game_demo = {"locale_content": {"title": "Game"},
             "auto_reject": False, "auto_confirm": True,
             "game_mode": "double",
             "limited_to": {"gender": "female", "level": ["hk_3", "hk_4"]},
             "field": ["v", "f"],
             "price": 50.0,
             "period": {"start": 1672052400000, "expiry": 1672059600000},
             "repeation": None,
             "equipment": {
    "shuttlecock": ["RSL - Superme", "LILING - G200"]},
    "admin": "test_user",
             "vacancy": 9,
             "veneu": "d47e1a52-4c3b-4483-8668-2f6045dc8c15",
             "field_rule": "default_rule",
             "game_type": "badminton",
             "max_player_count": 25,
             "metadata": {}}


CREATE TABLE IF NOT EXISTS game (
    id varchar(255) unique,
    title hstore,
    description hstore,
    assistant jsonb NOT NULL,
    game_mode varchar(255) NOT NULL,
    limited_to jsonb NOT NULL,
    field varchar[] NOT NULL,
    price real NOT NULL,
    period timestamp[] NOT NULL,
    repeation jsonb,
    equipment jsonb NOT NULL,
    permission jsonb  NOT NULL,
    vacancy int NOT NULL,
    veneu varchar(255) NOT NULL,
    field_rule varchar(255) NOT NULL,
    game_type varchar(255) NOT NULL,
    max_player_count int NOT NULL,
    creation timestamp NOT NULL,
    md timestamp NOT NULL,
    creator varchar(255) NOT NULL,
    last_modifier varchar(255) NOT NULL);


ALTER TABLE game 
ADD Column venue varchar(255) Not Null
Constraint venue_ref,
FOREIGN KEY (id) 
REFERENCES venue (id);


ALTER TABLE game 
ADD CONSTRAINT venue_ref
FOREIGN KEY (id)
REFERENCES public.venue(id)
ON DELETE CASCADE;


ALTER TABLE venue
ADD CONSTRAINT venue_id 
UNIQUE (id);


Alter Table game alter column creator set default 'system';
Alter Table game Alter column last_modifier set default 'system';
Alter Table game alter column creation set default (now() at time zone 'utc');
Alter Table game Alter column md set default (now() at time zone 'utc');


ALTER TABLE game ADD CONSTRAINT id UNIQUE(id);

Insert Into test_table(timestamps)
Values (array[to_timestamp(1672052400.0), to_timestamp(1672059600.0)])

Values (array[timestamp(1672052400.0), timestamp(1672059600.0)])

(array[ '2015-01-10 00:51:14', timestamp '2015-01-11 00:51:14']);


Insert Into test_table(json_test)
Values ('{"shuttlecock": ["RSL - Superme", "LILING - G200"]}'::jsonb)


-- url = "https://us-central1-sportlink-45001.cloudfunctions.net/games/create"
-- res: list = post(
-- url, headers={'content-type': 'application/json; charset=utf-8'}, data=json.dumps(game_demo)).json()

-- print(res)


SELECT (EXTRACT(EPOCH FROM md:: timestamp) * 1000)::bigint 
from unnest(Select period from game)
