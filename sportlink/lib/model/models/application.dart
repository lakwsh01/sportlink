import 'package:sportlink/model/models/base/base_model.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/base/locale_content.dart';

class Application extends BaseModel {
  final String user;
  final String game;
  final LocaleContent localeContent;
  final ApplicationStatus status;
  final DateTime autoExpiry;

  const Application._(
      {required this.user,
      required this.localeContent,
      required this.game,
      required this.status,
      required this.autoExpiry,
      required super.id,
      required super.metadata});

  factory Application(Map receipt) {
    final LocaleContent content =
        LocaleContent(receipt[ApplicationDBKey.localeContent.key]);
    return Application._(
        autoExpiry: DateTime.now().add(const Duration(days: 1)),
        game: receipt[ApplicationDBKey.game.key],
        user: receipt[ApplicationDBKey.user.key],
        localeContent: content,
        id: receipt[dbKeyId],
        status:
            receipt[ApplicationDBKey.status.key] ?? ApplicationStatus.pending,
        metadata: receipt[dbKeyMetaData]);
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Function(Map p1) get update => throw UnimplementedError();
}
