import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngConveror on List<double> {
  LatLng get latlng {
    if (length == 2) {
      return LatLng(first, last);
    } else {
      throw ArgumentError.value(this);
    }
  }
}
