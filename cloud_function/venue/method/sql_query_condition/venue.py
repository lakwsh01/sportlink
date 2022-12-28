

def geog_sensitive(lat: float, lng: float, distant: float):
    from helper.content_restructure import geog_builder
    anchor = geog_builder(lat=lat, lng=lng)

    return f"ST_DWithin(venue.geog, {anchor}, {distant})", f"ST_Distance(geog, {anchor})"


def district_sensitive(district: str):
    from helper.content_restructure import geog_builder

    return f"division -> 'district' = '{district}'"
