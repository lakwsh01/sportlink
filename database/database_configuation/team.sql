

CREATE TABLE IF NOT EXISTS team (
    id varchar(255) PRIMARY KEY,
    row SERIAL Not Null,
    type varchar(2) Not Null Default '99',
    game_types varchar[] Not Null,
    name hstore,
    description hstore,
    profile_id varchar(255) Not Null UNIQUE Default short_index('team'),
    membership jsonb,
    creation timestamp NOT NULL,
    md timestamp NOT NULL,
    creator varchar(255) NOT NULL,
    last_modifier varchar(255) NOT NULL
);


Alter Table team alter column creator set default 'system';
Alter Table team Alter column last_modifier set default 'system';
Alter Table team alter column creation set default (now() at time zone 'utc');
Alter Table team Alter column md set default (now() at time zone 'utc');
