-- required this.user,
-- required this.localeContent,
-- required this.game,
-- required this.status,
-- required this.autoExpiry,
-- required super.id,
-- required super.metadata
CREATE TABLE IF NOT EXISTS application (
    id varchar(255) PRIMARY KEY,
    row SERIAL Not Null,
    game varchar(255),
    status varchar(10) Not Null,
    target_user varchar(255),
    expiry timestamp,
    response jsonb,
    creation timestamp NOT NULL,
    md timestamp NOT NULL,
    creator varchar(255) NOT NULL,
    last_modifier varchar(255) NOT NULL);

ALTER TABLE application 
ADD CONSTRAINT target_user_ref
FOREIGN KEY (target_user)
REFERENCES public.user_profile(profile_id)
ON DELETE CASCADE;

ALTER TABLE application 
ADD CONSTRAINT game_ref
FOREIGN KEY (game)
REFERENCES public.game(id)
ON DELETE CASCADE;

ALTER TABLE application 
ADD CONSTRAINT venue_ref
FOREIGN KEY (venue)
REFERENCES public.venue(id);


Alter Table application alter column creator set default 'system';
Alter Table application Alter column last_modifier set default 'system';
Alter Table application alter column creation set default (now() at time zone 'utc');
Alter Table application Alter column md set default (now() at time zone 'utc');






