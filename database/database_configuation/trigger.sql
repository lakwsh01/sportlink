select id, venue,vacancy from game where id = 'game-40b98f6f70a04b0db329119bfaa8b4e2'; select * from application where game = 'game-40b98f6f70a04b0db329119bfaa8b4e2';

CREATE OR REPLACE FUNCTION vacancy_monitor()
RETURNS trigger AS
$$
DECLARE
anchor json;
random_id varchar;

BEGIN
    SELECT short_index(new.game, 6) INTO random_id;
    SELECT json_build_object('venue',game.venue,
                             'auto_confirm',(assistant->>'auto_confirm')::boolean,
                             'game_type', game_type
                             ) INTO anchor
        FROM GAME WHERE game.id = new.game;
    new.venue = anchor->>'venue';
    new.id = random_id;
    new.game_type = anchor->>'game_type';

    if (anchor->>'auto_confirm') then
        UPDATE game 
        SET vacancy = (vacancy -1) 
        where game.id = new.game and (assistant->>'auto_confirm')::boolean;
        new.status = 'accepted';
        new.response = json_build_object(
                        'mode', 'auto',
                        'user','system',
                        'response_at', (EXTRACT(EPOCH FROM now()::timestamp) * 1000)::bigint);
    end if;
    return new;
END
$$  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION vacancy_insert_monitor()
RETURNS trigger AS
$$
DECLARE
BEGIN
    UPDATE game SET vacancy = (vacancy -1) where game.id = new.game;
    return Null;
END
$$  LANGUAGE plpgsql;

CREATE TRIGGER new_application_trigger
BEFORE INSERT ON application
FOR EACH ROW
WHEN (pg_trigger_depth() < 1)
EXECUTE PROCEDURE vacancy_monitor();
