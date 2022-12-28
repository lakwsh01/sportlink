

# Minimal
_application_data_id = "id"
_application_data_venue = "venue"
_application_data_game = "game"
_application_data_game_type = "game_type"
_application_data_target_user = "target_user"
_application_data_apptime = "(EXTRACT(EPOCH FROM creation::timestamp) * 1000)::bigint as submition_dt"
_application_data_status = "status"
_application_data_expiry = "(EXTRACT(EPOCH FROM expiry::timestamp) * 1000)::bigint as expiry"
_application_data_response = "response"
_application_data_assistant = "assistant"
_user_profile_preview = "(Select json_build_object('name',name->'{locale}', 'description', description ->'{locale}','gender',gender, 'player_level', player_level -> game_type) FROM USER_PROFILE WHERE target_user = profile_id) as user_profile"

# Standard
# extend

minium = "id"
# preview = ",".join([])
# standard = ",".join([])
full = ",".join([_application_data_id,
                 _application_data_venue,
                 _application_data_game,
                 _application_data_game_type,
                 _application_data_target_user,
                 _application_data_apptime,
                 _application_data_status,
                 _application_data_expiry,
                 _application_data_response,
                 _application_data_assistant])

extend = ",".join([_application_data_id, _application_data_target_user,
                   _application_data_game, _application_data_apptime,
                   _application_data_status, _application_data_expiry,
                   _application_data_response, _user_profile_preview])
