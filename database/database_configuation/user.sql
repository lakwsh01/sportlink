--  final LocaleContent localeContent;
--   final String profileId;
--   final List<Membership> membership;
--   final PlayerLevel playerLevel;
--   final String gender;
--   final EquipmentType? equipmentType;

CREATE TABLE IF NOT EXISTS user_profile (
    id varchar(255) PRIMARY KEY,
    row SERIAL Not Null,
    type varchar(2) Not Null Default '99',
    name hstore,
    description hstore,
    profile_id varchar(255) Not Null Default random_index('profile'),
    membership jsonb,
    gender varchar(2),
    player_level hstore
);



Alter Table user_profile add column creation timestamp NOT NULL default (now() at time zone 'utc');
Alter Table user_profile add column md timestamp NOT NULL default (now() at time zone 'utc');
Alter Table user_profile add column creator varchar(255) NOT NULL default 'system';
Alter Table user_profile add column last_modifier varchar(255) NOT NULL default 'system';


Insert into user_profile(id,profile_id, name)
Values('test_user', 'test_user_profile_id', '"zh_HK"=>"測試用戶", "en"=>"Testor"')
