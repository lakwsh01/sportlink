import 'package:flutter/material.dart';
import 'package:sportlink/model/models/base/db_key.dart';

class MetaData {
  final DateTime creation;
  final DateTime lastModification;
  final String creator;
  final String lastModifier;

  const MetaData._(
      {required this.creation,
      required this.creator,
      required this.lastModification,
      required this.lastModifier});

  static Map newJson({Map? meta}) {
    // debugPrint("Current Timestamp: ${DateTime.now().millisecondsSinceEpoch}");
    return {
      MetadataKey.creator.key: meta?[MetadataKey.creator.key] ?? "user_001",
      MetadataKey.lastModifier.key:
          meta?[MetadataKey.lastModifier.key] ?? "user_001",
      MetadataKey.creation.key: meta?[MetadataKey.creation.key] ??
          DateTime.now().millisecondsSinceEpoch,
      MetadataKey.lastModification.key:
          meta?[MetadataKey.lastModification.key] ??
              DateTime.now().millisecondsSinceEpoch
    };
  }

  factory MetaData(Map meta) {
    final last = meta[MetadataKey.lastModifier.key];
    final create = meta[MetadataKey.creation.key];

    return MetaData._(
        creation: create == null ? DateTime.now() : DateTime(create),
        lastModification: last == null ? DateTime.now() : DateTime(last),
        creator: meta[MetadataKey.creator.key] ?? "",
        lastModifier: meta[MetadataKey.lastModifier.key] ?? "");
  }
}
