import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/locale_content.dart';
import 'package:sportlink/model/models/base/membership.dart';
import 'base/base_model.dart';

class User extends BaseModel {
  final LocaleContent localeContent;
  final String profileId;
  final List<Membership> membership;
  final PlayerLevel playerLevel;
  final String gender;
  final EquipmentType? equipmentType;

  const User(
      {required this.localeContent,
      required this.membership,
      required this.profileId,
      required this.equipmentType,
      required this.gender,
      required this.playerLevel,

      /// Base
      required super.id,
      required super.metadata});

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map p1) get update => throw UnimplementedError();
}
