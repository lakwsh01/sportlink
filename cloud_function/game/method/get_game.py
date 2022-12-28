
import method.sql_data_builder.game as data
import method.sql_query_condition.game as condition


def get_all_game(dt: int = None, district: list = None,
                 limitation: dict = None, game_type: str = "badminton",
                 offset: int = 0, limit=30):

    from helper.content_restructure import list_to_psql_array
    return """
        {division}
        SELECT {data} FROM GAME WHERE {condition} {division_inline} {offset} {limit}""".format(
        data=data.preview,
        condition=f"""{condition.datetime_sensitive(dt=dt)} and 
        {condition.vacancy_sensitive} and 
        {condition.game_type_sensitive(game_type=game_type)} 
        {condition.limitation_sensitive(limitation=limitation)}""",
        limit=f"limit {limit}",
        offset=f"offset {offset}",
        division_inline=f"and venue = ANY(Array(Select * from venues)::text[])" if (
            district) else "",
        division=f"WITH venues AS (SELECT id from venue where (division-> 'district')::TEXT = ANY({list_to_psql_array(district)}))" if (
            district) else ""
    )


def get_game_at(id: str):
    return "SELECT {data} FROM GAME WHERE id = '{id}'".format(id=id,
                                                              data=data.standard)
