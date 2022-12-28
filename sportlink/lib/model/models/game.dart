// import 'package:sportlink/model/models/base/locale_content.dart';

import 'package:flutter/material.dart' show DateTimeRange;
import 'package:sportlink/model/models/base/metadata.dart';
import 'package:sportlink/static/content/game_mode.dart';
// import './base/repeation.dart';
import './base/locale_content.dart';
import './base/db_key.dart';
import './base/base_model.dart';

class Game extends BaseModel<Game> {
  final DateTimeRange period;
  final String venue;
  final List<String> field;
  final int vacancy;
  final bool autoConfirm;
  final bool autoReject;
  final LocaleContent localeContent;
  final String admin;
  final double price;
  final GameMode gameMode;
  final String fieldRule;
  final int maxPlayerCount;

  /// nullable
  final Map<String, dynamic>? equipment;
  // final Repeation? repeation;
  final Map<LimitationType, dynamic>? limitedTo;
  final GameType gameType;

  const Game._(
      {required this.localeContent,
      required this.maxPlayerCount,
      required this.gameMode,
      required this.gameType,
      required this.admin,
      required this.autoConfirm,
      required this.autoReject,
      required this.equipment,
      required this.field,
      required this.limitedTo,
      required this.price,
      required this.period,
      required this.vacancy,
      required this.venue,
      // required this.repeation,
      required this.fieldRule,
      required super.id,
      required super.metadata});

  factory Game({required Map game, required String id}) {
    final Map? limit = game[GameDBKey.limitedTo.key];
    final Map<LimitationType, dynamic>? limitation = limit
        ?.map((key, value) => MapEntry(LimitationTypeMethod.type(key), value));
    final timeRangeStart = game[GameDBKey.period.key][dbKeyTimeRangeStart];
    final timeRangeExpiry = game[GameDBKey.period.key][dbKeyTimeRangeExpiry];
    // final Repeation? repeation = game[GameDBKey.repeation.key] != null
    //     ? Repeation.fromMap(Map.castFrom(game[GameDBKey.repeation.key]))
    //     : null;
    return Game._(
        maxPlayerCount: game[GameDBKey.maxPlayerCount.key],
        fieldRule: game[GameDBKey.fieldRule.key],
        gameMode: GameModeMethod.type(game[GameDBKey.gameMode.key]),
        gameType: GameType.badminton,
        localeContent: LocaleContent(game[GameDBKey.localeContent.key]),
        admin: game[GameDBKey.admin.key],
        autoConfirm: game[GameDBKey.autoConfirm.key],
        autoReject: game[GameDBKey.autoReject.key],
        equipment: game[GameDBKey.equipment.key],
        field: game[GameDBKey.field.key],
        limitedTo: limitation,
        price: (game[GameDBKey.price.key] as num).toDouble(),
        period: DateTimeRange(
            start: DateTime.fromMillisecondsSinceEpoch(timeRangeStart),
            end: DateTime.fromMillisecondsSinceEpoch(timeRangeExpiry)),
        vacancy: game[GameDBKey.vacancy.key],
        venue: game[GameDBKey.veneu.key],
        // repeation: repeation,
        id: id,
        metadata: MetaData(game[dbKeyMetaData]));
  }

  Map<String, dynamic> get template {
    return {
      GameDBKey.localeContent.key: localeContent,
      GameDBKey.autoConfirm.key: autoConfirm,
      GameDBKey.autoReject.key: autoReject,
      GameDBKey.admin.key: admin,
      GameDBKey.equipment.key: equipment,
      GameDBKey.limitedTo.key: limitedTo,
      GameDBKey.price.key: price,
      GameDBKey.vacancy.key: vacancy,
      GameDBKey.veneu.key: venue,
      dbKeyMetaData: metadata,
      dbKeyId: id
    };
  }

  @override
  Map get json => throw UnimplementedError();

  @override
  Game Function(Map) get update => (Map content) {
        final newLocale = content[GameDBKey.localeContent.key] != null
            ? LocaleContent(content[GameDBKey.localeContent.key])
            : null;
        // final newRepeation = content[GameDBKey.repeation.key] != null
        //     ? Repeation.fromMap(content[GameDBKey.repeation.key])
        //     : null;

        return Game._(
            maxPlayerCount:
                content[GameDBKey.maxPlayerCount.key] ?? maxPlayerCount,
            fieldRule: content[GameDBKey.fieldRule.key] ?? fieldRule,
            gameType: GameType.badminton,
            gameMode: content[GameDBKey.gameMode.key] != null
                ? GameModeMethod.type(content[GameDBKey.gameMode.key])
                : gameMode,
            localeContent: newLocale ?? localeContent,
            admin: content[GameDBKey.admin.key] ?? admin,
            autoConfirm: content[GameDBKey.autoConfirm.key] ?? autoConfirm,
            autoReject: content[GameDBKey.autoReject.key] ?? autoReject,
            equipment: content[GameDBKey.equipment.key] ?? equipment,
            field: content[GameDBKey.field.key] ?? field,
            limitedTo: limitedTo,
            price: content[GameDBKey.price.key] ?? price,
            period: content[GameDBKey.period.key] ?? period,
            vacancy: content[GameDBKey.vacancy.key] ?? vacancy,
            venue: content[GameDBKey.veneu.key] ?? venue,
            // repeation: newRepeation ?? repeation,
            id: id,
            metadata: metadata);
      };
}
