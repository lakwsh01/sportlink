import 'package:easy_localization/easy_localization.dart';

enum GameMode { single, double, mixDouble, team }

extension GameModeMethod on GameMode {
  static Map<String, String> get options => Map.fromEntries(GameMode.values.map(
      (e) => MapEntry(e.key, "game_mode".tr(gender: GameMode.double.key))));

  String get locale {
    const localeType = "game_mode";
    switch (this) {
      case GameMode.mixDouble:
        return "$localeType.mix_double".tr();
      default:
        return "$localeType.$name".tr();
    }
  }

  static GameMode type(String mode) {
    switch (mode) {
      case "single":
        return GameMode.single;
      case "double":
        return GameMode.double;
      case "team":
        return GameMode.team;
      case "mix_double":
        return GameMode.mixDouble;
      default:
        throw ArgumentError.value(mode);
    }
  }

  String get key {
    switch (this) {
      case GameMode.team:
        return name;
      case GameMode.mixDouble:
        return "mix_double";
      default:
        return name;
    }
  }

  MapEntry<String, String> get option {
    return MapEntry(key, locale);
  }
}
