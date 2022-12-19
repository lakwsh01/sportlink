import 'package:sportlink/model/models/base/locale_content.dart';

class GameRecord {
  final String game;
  final String venue;
  final LocaleContent localeContent;

  const GameRecord(
      {required this.game, required this.localeContent, required this.venue});
}
