import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/model/models/division.dart';

Future<Map> get allDivision async {
  final divisions =
      (await FirebaseDatabase.instance.ref("/public/divisio/hkg").once())
          .snapshot
          .value as Map?;
  final zones = ((divisions?["zones"] as List?)?.map((e) {
            return Zone(e);
          }) ??
          [])
      .toList();

  final province = ((divisions?["provinces"] as List?)?.map((e) {
            return Province(e);
          }) ??
          [])
      .toList();

  final district = ((divisions?["districts"] as List?)?.map((e) {
            return District(e);
          }) ??
          [])
      .toList();

  return {"zones": zones, "provinces": province, "districts": district};
}
