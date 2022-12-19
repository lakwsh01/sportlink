import 'package:sportlink/model/model.dart';
import 'package:sportlink/model/models/base/locale_content.dart';
import 'package:sportlink/model/models/game_record.dart';

class ProfileSnap extends BaseModel {
  final LocaleContent localeContent;
  final PlayerLevel playerLevel;
  final int gender;
  final List<GameRecord> gameRecords;
  final List<GameRecord> relatedRecords;

  const ProfileSnap._(
      {required this.gameRecords,
      required this.gender,
      required this.localeContent,
      required this.playerLevel,
      required this.relatedRecords,
      required super.id,
      required super.metadata});

  factory ProfileSnap(Map profileSnap) {
    return ProfileSnap._(
        gameRecords: [],
        gender: profileSnap[ProfileSnapDBKey.gender.key],
        localeContent: LocaleContent(profileSnap[dbKeyLocaleContent]),
        playerLevel: profileSnap[ProfileSnapDBKey.playerLevel.key],
        relatedRecords: [],
        id: profileSnap[dbKeyId],
        metadata: MetaData(profileSnap[dbKeyMetaData]));
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map p1) get update => throw UnimplementedError();
}
