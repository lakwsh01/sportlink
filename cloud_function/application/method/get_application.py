from method.sql_data_builder.application import extend


def sql_application_at(game_id: str, locale='zh_HK'):
    return f"SELECT {extend} FROM application WHERE game = '{game_id}'".format(locale=locale)
