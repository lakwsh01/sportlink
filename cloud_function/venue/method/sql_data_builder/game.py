# Minimal
_game_data_id = "id"
_game_data_venue = "venue"
_game_data_game_type = "game_type"
_game_data_vacancy = "vacancy"
_game_data_period = "Array[(EXTRACT(EPOCH FROM period[1]::timestamp) * 1000)::bigint,(EXTRACT(EPOCH FROM period[2]::timestamp) * 1000)::bigint]"

# Standard
_game_data_price = "price"
_game_data_field = "field"
_game_data_limited_to = "limited_to"
_game_data_game_mode = "game_mode"
_game_data_title = "title"
_game_data_description = "description"
_game_data_assistant = "assistant"
_game_data_equipment = "equipment"
_game_data_field_rule = "field_rule"
_game_data_max_player_count = "max_player_count"
_game_data_permission = "permission"
_game_data_repeation = "repeation"

# extend
_game_data_meta = "json_build_object() as metadata"


minium = "id"
preview = ",".join(
    [_game_data_id, _game_data_game_type, _game_data_vacancy, _game_data_period, _game_data_venue])

standard = ",".join([_game_data_id, _game_data_game_type, _game_data_vacancy,
                     _game_data_period, _game_data_venue,
                     _game_data_price, _game_data_field, _game_data_limited_to,
                     _game_data_game_mode, _game_data_title, _game_data_description,
                     _game_data_assistant, _game_data_equipment, _game_data_field_rule,
                     _game_data_max_player_count])


full = ",".join([_game_data_id, _game_data_game_type, _game_data_vacancy,
                 _game_data_period, _game_data_venue,
                 _game_data_price, _game_data_field, _game_data_limited_to,
                 _game_data_game_mode, _game_data_title, _game_data_description,
                 _game_data_assistant, _game_data_equipment, _game_data_field_rule,
                 _game_data_max_player_count, _game_data_meta, _game_data_permission, _game_data_repeation])

extend = preview
