import 'package:flutter/material.dart';
import 'package:sportlink/demo/venu.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/veneu.dart';
import 'package:sportlink/service/venue/get_all_venue.dart';

class Property {
  late List<Venue> venues;
  final List<Game> games = [];

  Future<void> initVenues() async {
    venues = await allVenues;
  }

  Set<String> get countries => venues
      .map((e) => e.division)
      .where((element) => element["country"] != null)
      .map((e) => e["country"] as String)
      .toSet();

  Set<String> provinces([String? parent]) => venues
      .map((e) => e.division)
      .where((element) =>
          (parent == null ? true : element["country"] == parent) &&
          element["province"] != null)
      .map((e) => e["province"]!)
      .toSet();

  Map<String, String> districts([String? parent]) => Map.fromEntries(venues
      .map((e) => e.division)
      .where((element) =>
          (parent == null ? true : element["zone"] == parent) &&
          element["district"] != null)
      .map((e) => MapEntry(e["district"] as String, e["district"] as String)));

  Map<String, String> zones([String? parent]) => Map.fromEntries(venues
      .map((e) => e.division)
      .where((element) =>
          (parent == null ? true : element["province"] == parent) &&
          element["zone"] != null)
      .map((e) => MapEntry(e["zone"] as String, e["zone"] as String)));

  Map<String, String> venuesAt([String? district]) {
    return Map.fromEntries(venues
        .where((element) => element.division["district"] == district)
        .map((e) => MapEntry(e.id, e.name)));
  }
}

enum DistrictType { country, province, zone, district }
