import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/locale_content.dart';
import 'package:sportlink/model/models/base/membership.dart';
import 'package:sportlink/model/models/base/metadata.dart';

import './base/base_model.dart';

class TeamProfile extends BaseModel {
  final LocaleContent localeContent;
  final List<Membership> membership;
  final int vacancy;
  final String paymentAccount;
  final TeamLimitationType teamLimitationType;

  const TeamProfile._(
      {required this.localeContent,
      required this.membership,
      required this.paymentAccount,
      required this.vacancy,
      required this.teamLimitationType,

      ///
      required super.id,
      required super.metadata});

  factory TeamProfile(Map map) {
    return TeamProfile._(
        localeContent: LocaleContent({LocaleContentDBKey.title.key: "title"}),
        membership: [const Membership(role: "", team: "", user: "")],
        paymentAccount: "paymentAccount",
        vacancy: 10,
        teamLimitationType: TeamLimitationType.unlimited,
        id: "id",
        metadata: MetaData({}));
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map) get update => throw UnimplementedError();
}
