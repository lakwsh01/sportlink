import 'package:flutter/material.dart';
import 'package:sportlink/model/models/base/db_key.dart';

class Repeation {
  final List<String>? weekdays;
  final DateTimeRange? period;

  const Repeation({required this.weekdays, required this.period});

  // factory Repeation.fromMap(Map<RepeationDBKey, dynamic> repeation) {
  //   return Repeation(
  //       weekdays: repeation[RepeationDBKey.weekdays],
  //       period: repeation[RepeationDBKey.period]);
  // }

  factory Repeation.fromMap(Map<String, dynamic> repeation) {
    final startAt = repeation[RepeationDBKey.period.key]?[dbKeyTimeRangeStart];
    final exipryAt =
        repeation[RepeationDBKey.period.key]?[dbKeyTimeRangeExpiry];
    return Repeation(
        weekdays: repeation[RepeationDBKey.weekdays.key] as List<String>?,
        period: startAt && exipryAt
            ? DateTimeRange(start: startAt, end: exipryAt)
            : null);
  }
}
