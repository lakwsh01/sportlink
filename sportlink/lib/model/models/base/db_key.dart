import 'package:sportlink/model/model.dart';

enum MetadataKey { creation, creator, lastModification, lastModifier }

const String dbKeyId = "id";
const String dbKeyMetaData = "metadata";
const String dbKeyTimeRangeStart = "start";
const String dbKeyTimeRangeExpiry = "expiry";
const String dbKeyLocaleContent = "locale_content";

extension MetadataKeyMethod on MetadataKey {
  String get key {
    switch (this) {
      case MetadataKey.lastModification:
        return "md";
      case MetadataKey.lastModifier:
        return "last_modifier";
      default:
        return name;
    }
  }
}

///
enum LocaleContentDBKey {
  userName,
  teamName,
  title,
  subtitle,
  inlineText,
  address,
  description
}

extension LocaleContentKeyMethod on LocaleContentDBKey {
  String get key {
    switch (this) {
      case LocaleContentDBKey.inlineText:
        return "inline_text";
      case LocaleContentDBKey.userName:
        return "user_name";
      case LocaleContentDBKey.teamName:
        return "team_naem";

      default:
        return name;
    }
  }
}

///
enum GameDBKey {
  localeContent,
  type,
  admin,
  autoConfirm,
  autoReject,
  equipment,
  field,
  level,
  limitedTo,
  price,
  period,
  vacancy,
  veneu,
  repeation
}

extension GameDBKeyMethod on GameDBKey {
  String get key {
    switch (this) {
      case GameDBKey.localeContent:
        return dbKeyLocaleContent;
      case GameDBKey.autoConfirm:
        return "auto_confirm";
      case GameDBKey.autoReject:
        return "auto_reject";
      case GameDBKey.limitedTo:
        return "limited_to";
      default:
        return name;
    }
  }
}

enum LimitationType { gender, age, level, team }

extension LimitationTypeMethod on LimitationType {
  String get key {
    switch (this) {
      case LimitationType.gender:
        return "gender";
      default:
        return name;
    }
  }

  static LimitationType type(String type) {
    switch (type) {
      case "age":
        return LimitationType.age;
      case "gender":
        return LimitationType.gender;
      case "level":
        return LimitationType.level;
      case "team":
        return LimitationType.team;
      default:
        throw ArgumentError.value(type);
    }
  }
}

enum EquipmentType { brandOfBall }

/// Repeation:
enum RepeationDBKey { period, weekdays }

extension RepeationDBKeyMethod on RepeationDBKey {
  String get key {
    switch (this) {
      case RepeationDBKey.period:
        return name;
      default:
        return name;
    }
  }
}

/// NotificationRequest
enum NotificationRequestDBKey {
  active,
  targetVenues,
  targetGender,
  targetPeroid,
  expiry
}

extension NotificationRequestDBKeyMethod on NotificationRequestDBKey {
  String get key {
    switch (this) {
      case NotificationRequestDBKey.targetVenues:
        return "target_venues";
      case NotificationRequestDBKey.targetPeroid:
        return "target_datetime";
      case NotificationRequestDBKey.targetGender:
        return "target_gender";
      default:
        return name;
    }
  }
}

/// Receipt
enum ReceiptDBKey { sender, receiver, game, localeContent }

extension ReceiptDBKeyMethod on ReceiptDBKey {
  String get key {
    switch (this) {
      case ReceiptDBKey.localeContent:
        return dbKeyLocaleContent;
      default:
        return name;
    }
  }
}

///
enum TeamLimitationType { standard, limited, unlimited }

enum PlayerLevel { a, b, c, d, e, f, g, h }

/// ProfileSnap
enum ProfileSnapDBKey {
  localeContent,
  playerLevel,
  gender,
  gameRecords,
  relatedRecords
}

extension ProfileSnapDBKeyMethod on ProfileSnapDBKey {
  String get key {
    switch (this) {
      case ProfileSnapDBKey.localeContent:
        return dbKeyLocaleContent;
      case ProfileSnapDBKey.playerLevel:
        return "player_level";
      case ProfileSnapDBKey.relatedRecords:
        return "related_records";
      case ProfileSnapDBKey.gameRecords:
        return "game_records";
      default:
        return name;
    }
  }
}

/// Application DB Key
enum ApplicationDBKey {
  game,
  autoExpiry,
  notification,
  user,
  status,
  localeContent
}

enum ApplicationStatus {
  rejected,
  submitted,
  accepted,
  pending,
  manuallyRetrieved,
  autoRetrieved
}

extension ApplicationStatusMethod on ApplicationStatus {
  static ApplicationStatus type(String status) {
    switch (status) {
      case "manually_retrieved":
        return ApplicationStatus.manuallyRetrieved;
      case "auto_retrieved":
        return ApplicationStatus.autoRetrieved;
      case "rejected":
        return ApplicationStatus.rejected;
      case "accepted":
        return ApplicationStatus.accepted;
      case "pending":
        return ApplicationStatus.pending;
      case "summited":
        return ApplicationStatus.submitted;
      default:
        throw ArgumentError.value(status);
    }
  }
}

extension ApplicationDBKeyMethod on ApplicationDBKey {
  String get key {
    switch (this) {
      case ApplicationDBKey.localeContent:
        return dbKeyLocaleContent;
      case ApplicationDBKey.autoExpiry:
        return "auto_expiry";
      default:
        return name;
    }
  }
}

/// Venue

enum VenueDBKey {
  facilities,
  division,
  geog,
  source,
  comingGames,
  name,
  address
}

extension VenueDBKeyMethod on VenueDBKey {
  String get key {
    switch (this) {
      case VenueDBKey.comingGames:
        return "coming_games";
      default:
        return name;
    }
  }
}

enum FacilityType { badminton, football, tennis, tableTennis, volluball }

enum GameType { badminton, football, tennis, tableTennis, volluball }

extension GameTypeMethod on GameType {
  String get key {
    switch (this) {
      case GameType.tableTennis:
        return "table_tennis";
      default:
        return name;
    }
  }

  static GameType type(String type) {
    switch (type) {
      case "badminton":
        return GameType.badminton;
      default:
        throw ArgumentError.value(type);
    }
  }
}

extension FacilityTypeMethod on FacilityType {
  String get key {
    switch (this) {
      case FacilityType.tableTennis:
        return "table_tennis";

      default:
        return name;
    }
  }

  static FacilityType type(String type) {
    switch (type) {
      case "badminton":
        return FacilityType.badminton;
      case "football":
        return FacilityType.football;
      default:
        throw ArgumentError.value(type);
    }
  }
}

enum ActivityType { badminton, football }
