
from method.sql_data_builder.game import _game_data_period, _game_data_id, _game_data_vacancy, _game_data_limited_to
_venue_data_id = "id"
_venue_data_geog = "Array[ST_Y(geog::geometry), ST_X(geog::geometry)] as geog"
_venue_data_address = "address -> '{locale}' as address"
_venue_data_name = "name -> '{locale}' as name"
_venue_data_division = "hstore_to_json(division) as division"
_venue_data_coming_game_count = "(Select count(*) FROM game WHERE game.venue = venue.id and  period[1] > now()) as game_count"
_venue_data_coming_game_first = f"array((Select json_build_object('id',game.{_game_data_id}, 'vacancy', game.{_game_data_vacancy}, 'limited_to', game.{_game_data_limited_to}, 'period', {_game_data_period}) FROM game WHERE game.venue = venue.id and  period[1] > now() order by period[1] limit 3)) as coming_games"

_venue_data_source = "hstore_to_json(source) as source"
_venue_data_description = "description -> '{locale}' as description"
_venue_data_facilities = "facilities"

# Minium
# Standard
# extend


minium = _venue_data_id
preview = ",".join([_venue_data_id, _venue_data_geog, _venue_data_name, _venue_data_address,
                   _venue_data_division, _venue_data_coming_game_count, _venue_data_coming_game_first])
standard = ",".join([_venue_data_id, _venue_data_geog,
                     _venue_data_name, _venue_data_address, _venue_data_division])
full = ",".join([_venue_data_id, _venue_data_geog, _venue_data_name, _venue_data_address, _venue_data_division,
                _venue_data_coming_game_count, _venue_data_coming_game_first, _venue_data_source, _venue_data_description, _venue_data_facilities])
extend = preview
