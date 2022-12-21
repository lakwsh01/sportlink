import 'package:flutter/material.dart';
import 'package:sportlink/demo/venu.dart';
import 'package:sportlink/model/models/division.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/veneu.dart';
import 'package:sportlink/service/division/get_all_division.dart';
import 'package:sportlink/service/venue/get_all_venue.dart';

class Property {
  late List<Venue> venues;
  final List<Game> games = [];
  late final List<Zone> _zones;
  late final List<District> _districts;
  late final List<Province> _provinces;

  Future<void> initVenues() async {
    final res = await Future.wait([allVenues, allDivision]);
    venues = res.first as List<Venue>;
    final division = res.last as Map;
    _zones = division["zones"];
    _districts = division["districts"];
    _provinces = division["provinces"];
  }

  Set<String> get countries {
    final availableV = venues
        .map((e) => e.division)
        .where((element) => element["country"] != null)
        .toSet();
    return {};
  }

  List<Zone> zones([String? parent]) {
    final availableDivision = venues
        .map((e) => e.division)
        .where((element) =>
            (parent == null ? true : element["province"] == parent) &&
            element["zone"] != null)
        .map((e) => e["zone"]!)
        .toSet();
    debugPrint("avaiable division : zone ::: $availableDivision");
    return _zones
        .where((element) => availableDivision.contains(element.code))
        .toList();
  }

  List<District> districts([String? parent]) {
    final availableDivision = venues
        .map((e) => e.division)
        .where((element) =>
            (parent == null ? true : element["zone"] == parent) &&
            element["district"] != null)
        .map((e) => e["district"]!)
        .toSet();
    debugPrint("avaiable division : zone ::: $availableDivision");
    return _districts
        .where((element) => availableDivision.contains(element.code))
        .toList();
  }

  Map<String, String> venuesAt([String? district]) {
    return Map.fromEntries(venues
        .where((element) => element.division["district"] == district)
        .map((e) => MapEntry(e.id, e.name)));
  }
}

enum DistrictType { country, province, zone, district }
