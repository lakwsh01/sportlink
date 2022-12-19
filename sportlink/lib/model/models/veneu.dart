import 'package:sportlink/model/models/base/base_model.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/locale_content.dart';
import 'package:sportlink/model/models/base/metadata.dart';
import 'package:sportlink/model/models/base/venue_service_id.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:sportlink/service/converter/converters/geographic.dart';

class Venue extends BaseModel {
  final String name;
  final String address;
  final LatLng geog;
  final VenueSource source;
  final List<FacilityType> facilities;
  final Map comingGames;
  final Map<String, String> division;

  const Venue._(
      {required this.name,
      required this.address,
      required this.facilities,
      required this.geog,
      required this.source,
      required this.comingGames,
      required this.division,
      required super.id,
      required super.metadata});

  factory Venue(Map venue) {
    return Venue._(
        division: Map.castFrom<dynamic, dynamic, String, String>(
            venue[VenueDBKey.division.key]),
        name: venue[VenueDBKey.name.key],
        address: venue[VenueDBKey.address.key],
        geog: (venue[VenueDBKey.geog.key] as List).cast<double>().latlng,
        source: VenueSource(venue[VenueDBKey.source.key]),
        comingGames: venue[VenueDBKey.comingGames.key],
        facilities: [FacilityType.badminton],
        id: venue[dbKeyId],
        metadata: MetaData(venue[dbKeyMetaData] ?? {}));
  }

  @override
  // TODO: implement json
  Map get json => throw UnimplementedError();

  @override
  // TODO: implement update
  Function(Map p1) get update => throw UnimplementedError();
}
