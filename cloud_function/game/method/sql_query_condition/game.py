

vacancy_sensitive = "vacancy >= 1"


def datetime_sensitive(dt: int):
    if (dt):
        from helper.content_restructure import dt_to_psql_timestamp
        stamp = dt_to_psql_timestamp(md_mill=dt)
        return f"period[1] > {stamp}"
    else:
        return "period[1] > now()"


def game_type_sensitive(game_type: str = "badminton"):
    return f"game_type = '{game_type}'"


def limitation_sensitive(limitation: dict = None):
    # "limited_to": {"gender": li_gender, "level": ls},
    if (limitation):
        from helper.content_restructure import list_to_psql_array
        rules = []
        for k, v in limitation.items():
            if (k == "level"):
                rules.append(
                    f"jsonb_array_to_text_array(limited_to -> '{k}') && {list_to_psql_array(v)}::text[]")
            elif (k == "gender"):
                rules.append(
                    f"(limited_to ->>'{k}') = ANY({list_to_psql_array(v)}::text[])")
            elif (type(v) == list):
                rules.append(
                    f"jsonb_array_to_text_array(limited_to -> '{k}') && {list_to_psql_array(v)}::text[]")
            else:
                rules.append(f"(limited_to ->>'{k}') = '{v}'")

        return " AND " + " AND ".join(rules)
    else:
        return ""
