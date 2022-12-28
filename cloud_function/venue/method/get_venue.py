
import method.sql_data_builder.venue as data
import method.sql_query_condition.venue as condition


def get_all_venue(geog: list, offset: int = 0, limit=30, locale="zh_HK"):
    con_geog, order = condition.geog_sensitive(
        lat=geog[0], lng=geog[1], distant=0)
    return """
        SELECT {data} FROM Venue order by {order} {offset} {limit}""".format(
        data=data.preview.format(locale=locale),
        offset=f"offset {offset}",
        limit=f"limit {limit}",
        order=order
    )


def get_venue_nearby(geog: list, offset: int = 0, locale="zh_HK"):
    con_geog, con_order = condition.geog_sensitive(
        lat=geog[0], lng=geog[1], distant=2500)
    return """
        SELECT {data} FROM Venue 
        where {condition}
        order by {order}
        {offset} {limit}
        """.format(
        condition=con_geog,
        order=con_order,
        data=data.preview.format(locale=locale),
        offset=f"offset {offset}")


def get_venue_at_district(district: str, locale="zh_HK"):
    return """
        SELECT {data} FROM VENUE WHERE {condition}""".format(
        data=data.preview.format(locale=locale),
        condition=condition.district_sensitive(district=district))


def get_venue_at(id: str, locale: str = 'zh_HK'):
    return "SELECT {data} FROM GAME WHERE id = '{id}'".format(id=id,
                                                              data=data.preview.format(
                                                                  locale=locale))
