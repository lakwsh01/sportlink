import 'package:flutter/material.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/metadata.dart' as g;
import 'package:sportlink/model/models/base/repeation.dart';
import './base/base_model.dart';

class NotificationRequest extends BaseModel {
  final bool active;
  final DateTime expiry;

  final Repeation? repeation;
  final List<String>? targetVenues;
  final List<String>? targetGender;
  final DateTimeRange? targetPeroid;

  const NotificationRequest._(
      {required this.active,
      required this.expiry,
      required this.targetPeroid,
      required this.targetGender,
      required this.targetVenues,
      required this.repeation,
      required super.id,
      required super.metadata});

  factory NotificationRequest(Map notificationRequest) {
    final targetPeroidStart =
        (notificationRequest[NotificationRequestDBKey.targetPeroid.key]
            as Map?)?[dbKeyTimeRangeStart];
    final targetPeroidExpiry =
        (notificationRequest[NotificationRequestDBKey.targetPeroid.key]
            as Map?)?[dbKeyTimeRangeExpiry];
    final targetGender =
        (notificationRequest[NotificationRequestDBKey.targetGender.key]
                as List?)
            ?.cast<String>();
    final targetVenues =
        (notificationRequest[NotificationRequestDBKey.targetVenues.key]
                as List?)
            ?.cast<String>();
    return NotificationRequest._(
        active: notificationRequest[NotificationRequestDBKey.active.key],
        expiry: notificationRequest[NotificationRequestDBKey.expiry.key],
        targetPeroid: targetPeroidExpiry != null && targetPeroidStart != null
            ? DateTimeRange(
                start: DateTime(targetPeroidStart),
                end: DateTime(targetPeroidExpiry))
            : null,
        targetGender: targetGender,
        targetVenues: targetVenues,
        id: notificationRequest[dbKeyId],
        repeation: null,
        metadata: g.MetaData(notificationRequest[dbKeyMetaData]));
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map p1) get update => throw UnimplementedError();
}
