enum DefaultVenueSource {
  googlePlace,
  openStreetMap,
  facebook,
  instagram,
  mapbox,
  phone,
  website
}

class VenueSource {
  final String? googlePlaceId;
  final String? facebook;
  final String? openStreetMap;
  final String? mapbox;
  final String? instagram;
  final String? phone;
  final String? email;
  final DefaultVenueSource defaultVenueSource;

  const VenueSource._(
      {required this.googlePlaceId,
      required this.facebook,
      required this.openStreetMap,
      required this.mapbox,
      required this.instagram,
      required this.phone,
      required this.email,
      required this.defaultVenueSource});

  factory VenueSource(Map source) {
    return VenueSource._(
        googlePlaceId: source["google_place_sdk"],
        facebook: source["facebook"],
        openStreetMap: source["openStreetMap"],
        mapbox: source["mapbox"],
        instagram: source["instagram"],
        phone: source["phone"],
        email: source["email"],
        defaultVenueSource: DefaultVenueSource.googlePlace);
  }
}
