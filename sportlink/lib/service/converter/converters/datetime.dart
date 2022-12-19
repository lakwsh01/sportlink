import 'package:flutter/material.dart';
import './int.dart';

extension DateTimeRangeMethod on DateTimeRange {
  String get generalPickUpTimeRangeStatement {
    final starting = TimeOfDay.fromDateTime(start).formatAsTwoDigit();
    final ending = TimeOfDay.fromDateTime(end).formatAsTwoDigit();
    final now = DateTime.now();
    if (now.isSameDay(start)) {
      return "今日 $starting-$ending 提取";
    } else {
      return "${start.day}/${start.month}/${start.year}・$starting-$ending 提取";
    }
  }
}

extension DateTimeMethod on DateTime {
  bool isSameDay(DateTime dt) {
    return (dt.day == day && dt.month == month && dt.year == year);
  }

  String format([String pattern = "dd-mm-yy", bool doubleDigit = true]) {
    String dd;
    String mm;
    String hh;
    String mn;
    String ss;

    final String yy = year.toString();
    String _pattern = pattern;
    if (doubleDigit) {
      dd = IntMethod.toStringAsFixedDigit(value: day);
      mm = IntMethod.toStringAsFixedDigit(value: month);
      hh = IntMethod.toStringAsFixedDigit(value: hour);
      mn = IntMethod.toStringAsFixedDigit(value: minute);
      ss = IntMethod.toStringAsFixedDigit(value: second);
    } else {
      dd = day.toString();
      mm = month.toString();
      hh = hour.toString();
      mn = minute.toString();
      ss = second.toString();
    }

    _pattern = _pattern.replaceFirst("mm", mm);
    _pattern = _pattern.replaceFirst("yy", yy);
    _pattern = _pattern.replaceFirst("dd", dd);
    _pattern = _pattern.replaceFirst("mn", mn);
    _pattern = _pattern.replaceFirst("hh", hh);
    _pattern = _pattern.replaceFirst("ss", ss);
    return _pattern;
  }

  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
    return DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.millisecond);
  }

  bool isBeforeTimeOfDay(TimeOfDay timeOfDay) {
    final DateTime now =
        DateTime.now().copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
    return isBefore(now);
  }

  bool isAfterTimeOfDay(TimeOfDay timeOfDay) {
    final DateTime now =
        DateTime.now().copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
    return isAfter(now);
  }
}

const kHourConstant = 3600000;
const kMinConstant = 60000;
const kSecondConstant = 1000;

extension TimeOfDayMethod on TimeOfDay {
  DateTime toDateTime([DateTime? dateTime]) {
    final _dt = dateTime ?? DateTime.now();
    return DateTime(_dt.year, _dt.month, _dt.day, hour, minute);
  }

  Duration deltaOf(TimeOfDay anchor) {
    final mainDT = hour * kHourConstant + minute * kMinConstant;
    final anchorDT = anchor.hour * kHourConstant + anchor.minute * kMinConstant;

    return Duration(milliseconds: mainDT - anchorDT);
  }

  static TimeOfDay nearestInterval(TimeOfDay dt, [int interval = 15]) {
    final segnment = (60 / interval).ceil();
    final List<int> intervals = List.generate(segnment, (int index) {
      return (index * interval).ceil();
    });
    if (intervals.any((element) => element >= dt.minute)) {
      return TimeOfDay(
          hour: dt.hour,
          minute: intervals.firstWhere((element) => element > dt.minute));
    } else {
      return TimeOfDay(hour: dt.hour + 1, minute: 0);
    }
  }

  String formatAsTwoDigit([String pattern = "hh:mn"]) {
    String _pattern = pattern;
    final hh = IntMethod.toStringAsFixedDigit(value: hour);
    final mn = IntMethod.toStringAsFixedDigit(value: minute);

    _pattern = _pattern.replaceFirst("hh", hh);
    _pattern = _pattern.replaceFirst("mn", mn);

    return _pattern;
  }

  int formatAsMd([String pattern = "hh:mn"]) {
    final twoDigit = formatAsTwoDigit(pattern);
    // print("two Digit at formatAsMd : $twoDigit");
    final List<String> args = twoDigit.split(":");
    final List<String> pattens = pattern.split(":");

    int md = 0;

    for (var i = 0; i < pattens.length; i++) {
      final element = args.elementAt(i);
      final p = pattens.elementAt(i);
      final int? count = int.tryParse(element);
      if (count != null) {
        if (p == "hh") {
          md = md + (count * kHourConstant);
          // print(count * kHourConstant);
        } else if (p == "mn") {
          md = md + count * kMinConstant;
          // print(count * kMinConstant);
        } else if (p == "ss") {
          md = md + count * kSecondConstant;
        }
      }
      // print(md);
    }

    return md;
  }
}

TimeOfDay decodeIntToTimeOfDay(int md, [String pattern = "hh:mn"]) {
  final hh = (md / kHourConstant).floor();
  final mn = (md.remainder(kHourConstant) / kMinConstant).floor();
  final res = TimeOfDay(hour: hh, minute: mn);

  return res;
}

extension DatetimePeroidFormator on DayPeriod {
  String get artificaial {
    return this == DayPeriod.am ? "AM" : "PM";
  }
}

Map buildWeeklyRepeatingSchedule(
    {required int startMd,
    required int endMd,
    required Iterable<int> days,
    required Map ori,
    bool resetContent = false}) {
  days.forEach((d) {
    if (resetContent) {
      // print("d $d should reset");
      ori.remove("day_$d");
    }
    if (ori.containsKey("day_$d")) {
      // print("d contain $d ${ori[d.toString()]}");
      ori["day_$d"]["$startMd"] = {
        "start": startMd,
        "end": endMd,
        "end_at_next_day": startMd >= endMd
      };
    } else {
      ori["day_$d"] = {
        startMd.toString(): {
          "start": startMd,
          "end": endMd,
          "end_at_next_day": startMd >= endMd
        }
      };
    }
  });
  return ori;
}

bool existingSecheduleCheck(
    {
    // required Map<int, Map<int, Map>> oriRecord,
    required Iterable<int> applyingDay,
    required int startMd,
    required int endMd,
    required Map? oriRecord}) {
  final bool crossday = (startMd > endMd);
  if (oriRecord?.isEmpty ?? true) {
    return true;
  } else if (applyingDay.isEmpty) {
    return true;
  } else if (crossday) {
    return false;
  } else {
    bool check = true;
    applyingDay.forEach((e) {
      if (check == true && oriRecord!.containsKey("day_$e")) {
        final checker = (oriRecord["day_$e"] as Map).entries;
        // print(checker);
        if (checker.any((check) {
          if (check.value["end_at_next_day"] == true) {
            // print("check return end_at_next_day");
            return true;
          }
          final int a = check.value["start"];
          final int b = check.value["end"];
          final int x = startMd;
          final int y = endMd;

          if ((a == x) ||
              (b == x) ||
              (a <= x && x < b) ||
              (a <= y && y <= b) ||
              (x <= a && a <= y) ||
              (x <= b && b <= y)) {
            // print("check should be false under cross check");
            return true;
          } else {
            return false;
          }
        })) {
          // print("check should be false");
          check = false;
          // print(check);
        }
      }
    });
    return check;
  }
}

List<String> currentTimeSegment(Map target) {
  final current = DateTime.now();
  // final currentMd =
  //     current.hour * kHourConstant + current.minute * kMinConstant;
  final day = current.weekday == 7 ? 0 : current.weekday;
  final dayTarget = target["day_$day"] as Map?;
  print("day $day");
  print("dayTarget = $dayTarget");
  if (dayTarget == null) {
    return ["本日公休"];
  } else {
    return dayTarget.entries.map((e) {
      final TimeOfDay start = decodeIntToTimeOfDay(e.value["start"]);
      final TimeOfDay end = decodeIntToTimeOfDay(e.value["end"]);
      final bool atNextDay = e.value["end_at_next_day"];
      return start.formatAsTwoDigit() +
          "-" +
          (atNextDay ? "隔天" : "") +
          end.formatAsTwoDigit();
    }).toList();
  }
}

String weekDayTag(String tag) {
  switch (tag) {
    case "day_1":
      return "星期一";
    case "day_2":
      return "星期二";
    case "day_3":
      return "星期三";
    case "day_4":
      return "星期四";
    case "day_5":
      return "星期五";
    case "day_6":
      return "星期六";
    default:
      return "星期日";
  }
}

Map<String, List<String?>> scheduledTextContent(Map target) {
  final List<MapEntry<String, List<String?>>> scheduleText =
      List.generate(7, (dayIndex) {
    final mds = (target["day_$dayIndex"] as Map?)?.entries;
    if (mds?.isEmpty ?? true) {
      return MapEntry("day_$dayIndex", ["本日店休"]);
    } else {
      return MapEntry(
          "day_$dayIndex",
          List.generate(mds?.length ?? 0, (index) {
            final startMd = mds?.elementAt(index).value["start"];
            final endMd = mds?.elementAt(index).value["end"];
            final nextDay = mds?.elementAt(index).value["end_at_next_day"];
            // print("startMd $startMd   endMd $endMd");
            final TimeOfDay? startTime =
                startMd != null ? decodeIntToTimeOfDay(startMd) : null;
            final TimeOfDay? endTime =
                endMd != null ? decodeIntToTimeOfDay(endMd) : null;
            return (startTime == null || endTime == null)
                ? null
                : " ${startTime.formatAsTwoDigit()} - ${nextDay ? "隔天 " : ""}${endTime.formatAsTwoDigit()}";
          }));
    }
  });

  return Map.fromEntries(scheduleText);
}
