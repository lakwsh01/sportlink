abstract class Division {
  final String code;
  final String locale;

  const Division({required this.locale, required this.code});
}

class Zone extends Division {
  final String? province;
  final String? country;

  const Zone._(
      {this.province,
      this.country,
      required String locale,
      required String code})
      : super(locale: locale, code: code);
  factory Zone(Map zone) {
    return Zone._(
        code: zone["code"],
        country: zone["country"],
        province: zone["province"],
        locale: zone["locale"]["zh"]);
  }
}

class District extends Division {
  final String? province;
  final String? country;
  final String? zone;

  const District._(
      {this.province,
      this.country,
      this.zone,
      required String locale,
      required String code})
      : super(locale: locale, code: code);
  factory District(Map district) {
    return District._(
        zone: district["zone"],
        code: district["code"],
        country: district["country"],
        province: district["province"],
        locale: district["locale"]["zh"]);
  }
}

class Province extends Division {
  final String? province;
  final String? country;

  const Province._(
      {this.province,
      this.country,
      required String locale,
      required String code})
      : super(locale: locale, code: code);
  factory Province(Map province) {
    return Province._(
        code: province["code"],
        country: province["country"],
        province: province["province"],
        locale: province["locale"]["zh"]);
  }
}
