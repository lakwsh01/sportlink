import 'package:flutter/material.dart';
import 'package:sportlink/model/models/base/db_key.dart';

List<String> levels(ActivityType type,
    [Locale locale = const Locale("ZH", "hk")]) {
  switch (type) {
    case ActivityType.badminton:
      if (locale.countryCode == "hk") {
        return playerLevelHK;
      } else {
        return playerLevelHK;
      }
    default:
      throw ArgumentError("Unsupported");
  }
}

const playerLevelHK = [
  "hk_0",
  "hk_1",
  "hk_2",
  "hk_3",
  "hk_4",
  "hk_5",
  "hk_6",
  "hk_7"
];
