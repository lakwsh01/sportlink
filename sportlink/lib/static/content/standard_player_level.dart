import 'package:flutter/material.dart';
import 'package:sportlink/model/models/base/db_key.dart';

List<String> levels(GameType type, [Locale locale = const Locale("ZH", "hk")]) {
  switch (type) {
    case GameType.badminton:
      if (locale.countryCode == "hk") {
        return badmintonPlayerLevelHK;
      } else {
        return badmintonPlayerLevelHK;
      }
    default:
      throw ArgumentError("Unsupported");
  }
}

const badmintonPlayerLevelHK = [
  "hk_0",
  "hk_1",
  "hk_2",
  "hk_3",
  "hk_4",
  "hk_5",
  "hk_6",
  "hk_7"
];
