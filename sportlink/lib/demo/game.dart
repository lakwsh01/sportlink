import 'package:sportlink/model/models/base/db_key.dart';
import 'package:uuid/uuid.dart';

String randomGameName([String? heading]) {
  final String uuid = const Uuid().v4().split("-")[2];
  return "${heading ?? "Countin 香港羽毛球公開賽"}#$uuid";
}

final gameDemo = {
  GameDBKey.period.key: {
    dbKeyTimeRangeStart: 0,
    dbKeyTimeRangeExpiry: 20000000
  },
  GameDBKey.veneu.key: "venue",
  GameDBKey.field.key: "field",
  GameDBKey.vacancy.key: 10,
  GameDBKey.autoConfirm.key: true,
  GameDBKey.autoReject.key: false,
  GameDBKey.localeContent.key: {"title": randomGameName()},
  GameDBKey.admin.key: "user_123",
  GameDBKey.price.key: 24.0,
  GameDBKey.type.key: "badminton",
  dbKeyId: "game_id_01",
  dbKeyMetaData: {
    MetadataKey.lastModifier.name: "user_123",
    "md": 0,
    MetadataKey.creation.name: 0,
    MetadataKey.creator.name: "user_123"
  }
};
