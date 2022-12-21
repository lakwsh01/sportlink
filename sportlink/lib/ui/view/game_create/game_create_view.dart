import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/demo/venu.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/game.dart';
import 'package:sportlink/model/models/veneu.dart';
import 'package:sportlink/service/converter/converter.dart';
import 'package:sportlink/state/property.dart';
import 'package:sportlink/static/content/equments/badminton/shuttlecocks.dart';
import 'package:sportlink/static/content/game_mode.dart';
import 'package:sportlink/static/content/local.dart';
import 'package:sportlink/static/content/standard_player_level.dart';
import 'package:sportlink/ui/view/user/profile_view.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:sportlink/ui/widget/editor/date_time_picker.dart';
import 'package:sportlink/ui/widget/editor/multiple_line_text_editor.dart';
import 'package:sportlink/ui/widget/editor/option_selector.dart';
import 'package:sportlink/ui/widget/editor/tree_item_picker.dart';
import 'package:sportlink/ui/widget/editor/tree_selector.dart';
import 'package:sportlink/ui/widget/editor/multiple_line_option_selector.dart';
import 'package:sportlink/ui/widget/editor/number_editor.dart';
import 'package:sportlink/ui/widget/editor/options_checker.dart';
import 'package:sportlink/ui/widget/editor/single_line_text_editor.dart';
import 'package:sportlink/ui/widget/ui/multiple_line_detail.dart';
import 'package:sportlink/ui/widget/ui/single_line_content_detail.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class GameCreatorView extends StatefulWidget {
  const GameCreatorView({super.key});

  @override
  State<GameCreatorView> createState() => _GameCreatorViewState();
}

class _GameCreatorViewState extends State<GameCreatorView> {
  final nowDt = DateTime.now();
  late final minDt =
      DateTime(nowDt.year, nowDt.month, nowDt.day + 2, nowDt.hour);
  late DateTimeRange targetDTRange = DateTimeRange(
      start: minDt, end: minDt.add(Duration(hours: minDt.hour + 2)));
  List<String> fields = [];
  List<String> targetLevels = [];
  double price = 50;
  int vacancy = 0;
  bool autoConfirm = true;
  GameMode targetGameMode = GameMode.double;
  String targetGender = "all";
  Venue? venue;
  List<String> targetShuttlecocks = [];
  String fieldRule = "default_rule";
  bool get onSaveChecker {
    final dt = DateTime.now();

    return venue != null &&
        targetDTRange.start.isAfter(dt) &&
        fields.isNotEmpty &&
        targetLevels.isNotEmpty &&
        vacancy > 0;
  }

  void onSave() {
    if (onSaveChecker) {
      final event = {
        GameDBKey.localeContent.key: {LocaleContentDBKey.title.key: "Game"},
        GameDBKey.autoReject.key: false,
        GameDBKey.autoConfirm.key: autoConfirm,
        GameDBKey.gameMode.key: targetGameMode.key,
        GameDBKey.limitedTo.key: {
          LimitationType.gender.key: targetGender,
          LimitationType.level.key: targetLevels
        },
        GameDBKey.field.key: fields,
        GameDBKey.price.key: price,
        GameDBKey.period.key: {
          dbKeyTimeRangeStart: targetDTRange.start.millisecondsSinceEpoch,
          dbKeyTimeRangeExpiry: targetDTRange.end.millisecondsSinceEpoch
        },
        GameDBKey.repeation.key: null,
        GameDBKey.equipment.key: {"shuttlecock": targetShuttlecocks},
        GameDBKey.admin.key: "test_user",
        GameDBKey.vacancy.key: vacancy,
        GameDBKey.veneu.key: venue!.id,
        GameDBKey.fieldRule.key: fieldRule,
        dbKeyMetaData: {}
      };

      debugPrint("save new game ::: detail : $event");

      final newGame = Game(game: event, id: "newGAme ID");
    } else {
      debugPrint("bad record");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: "新活動", trailingText: "發佈", onDone: onSave, onCancel: () {}),
        body: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(children: const [Text("請準確填寫場次資料")])),
              SingleLineContentDetail(
                  label: "類型", onEdit: ((context) {}), content: "羽毛球"),
              SingleLineContentDetail(
                  label: "模式",
                  onEdit: ((context) async {
                    final String? mode = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return OptionSelector(
                          onCancel: () {},
                          onDone: (option) {},
                          options: Map.fromEntries(
                              GameMode.values.map((e) => e.option)),
                          title: "選擇對賽模式");
                    }));

                    if (mode != null) {
                      targetGameMode = GameModeMethod.type(mode);
                      setState(() {});
                    }
                  }),
                  content: targetGameMode.locale),
              MultipleLineDetail(title: "波款", itemBuilder: [
                (funct) {
                  return funct(targetShuttlecocks.map((e) => e).join("\n"),
                      () async {
                    final List<String>? _targetShuttlecocks = await Navigator
                            .of(context)
                        .push<List<String>>(MaterialPageRoute(
                            builder: (_) {
                              return MultipleLineTextEditor(
                                  title: "設定羽毛球型號",
                                  onAdd: (deafultCallback, callback) async {
                                    String? customValue;
                                    String? brand;
                                    final model = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => TreeSelector(
                                                  levels: ["brand", "model"],
                                                  onNextLevelSetter:
                                                      ((nextLevel, currentLevel,
                                                          updateCallback) {
                                                    brand = nextLevel;
                                                    final newOptions =
                                                        Map.fromEntries(
                                                            (shuttlecocks[
                                                                        nextLevel]
                                                                    as List<
                                                                        String>)
                                                                .map((e) =>
                                                                    MapEntry(
                                                                        e, e)));
                                                    updateCallback.call(
                                                        newOptions, true);
                                                  }),
                                                  onConfirm: (value) {},
                                                  onCancel: () {
                                                    Navigator.of(context)
                                                        .pop(null);
                                                  },
                                                  initOptions: Map.fromEntries(
                                                      shuttlecocks.keys.map(
                                                          (e) =>
                                                              MapEntry(e, e))),
                                                  title: "新增羽毛球型號",
                                                  bottom: SafeArea(
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            await Navigator.of(
                                                                    context)
                                                                .push<String>(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) {
                                                              return SingleLineTextContentEditor(
                                                                  onDone: (v) {
                                                                    Navigator.of(context).popUntil((route) =>
                                                                        route
                                                                            .settings
                                                                            .name ==
                                                                        "settings_balltype");
                                                                    customValue =
                                                                        v;
                                                                  },
                                                                  title:
                                                                      "新增羽毛球型號");
                                                            }));
                                                          },
                                                          child: const Text(
                                                              "搵唔到型號？ 可以自己打"))),
                                                )));

                                    debugPrint("on add $brand - $model");
                                    if (customValue != null) {
                                      callback.call(customValue);
                                    } else if (brand != null && model != null) {
                                      callback.call("$brand - $model");
                                    }
                                  });
                            },
                            settings:
                                RouteSettings(name: "settings_balltype")));

                    debugPrint("brand:: $_targetShuttlecocks");
                    if (_targetShuttlecocks != null) {
                      targetShuttlecocks = _targetShuttlecocks;
                      setState(() {});
                    }
                  });
                }
              ]),
              SingleLineContentDetail(
                  label: "性別",
                  onEdit: (context) async {
                    final target = await Navigator.of(context)
                        .push<String>(MaterialPageRoute(builder: (_) {
                      return OptionSelector(
                          defaultOption: "all",
                          options: Map.fromEntries(targetGenders.map(
                              (String e) => MapEntry(
                                  e, LocaleInitial.gender.labelAt(e)))),
                          title: "選擇參加者性別要求");
                    }));
                    if (target != null) {
                      targetGender = target;
                      setState(() {});
                    }
                  },
                  content: "gender.$targetGender".tr()),
              SingleLineContentDetail(
                  label: "時間",
                  onEdit: ((context) {
                    DateTime? starting;

                    showDatetimePicker(context, "開始時間", "NEXT", (dt) {
                      Navigator.of(context).pop();
                      starting = dt;
                      Future.delayed(const Duration(milliseconds: 250), () {
                        showDatetimePicker(context, "結束時間", "DONE", (dt) {
                          Navigator.of(context).pop();
                          // debugPrint(
                          //     "starting : ${starting?.toIso8601String()} - ${closing?.toIso8601String()}");
                          targetDTRange =
                              DateTimeRange(start: starting!, end: dt);
                          setState(() {});
                        }, starting!, starting!.add(const Duration(hours: 2)));
                      });
                    }, minDt);
                  }),
                  content:
                      "${targetDTRange.start.format("yy-mm-dd")}\n${targetDTRange.end.format("hh:mn")} - ${targetDTRange.start.format("hh:mn")}  (${targetDTRange.duration.inHours}小時 ${(targetDTRange.duration.inMinutes).remainder(60)} 分鐘)"),
              SingleLineContentDetail(
                  label: "場館",
                  onEdit: ((context) async {
                    final state = RM.get<Property>().state;
                    final String? venue = await Navigator.of(context)
                        .push<String>(MaterialPageRoute(builder: (_) {
                      return TreeSelector(
                          levels: const ["zones", "districts", "venues"],
                          onNextLevelSetter:
                              (nextLevel, currentLevel, updateCallback) {
                            if (currentLevel == "zones") {
                              final newOptions = state.districts(nextLevel);
                              if (newOptions.length == 1) {
                                final venues =
                                    state.venuesAt(newOptions.first.code);
                                updateCallback.call(venues, true);
                              } else {
                                updateCallback.call(
                                    Map.fromEntries(state
                                        .districts(nextLevel)
                                        .map(
                                            (e) => MapEntry(e.code, e.locale))),
                                    false);
                              }
                            } else if (currentLevel == "districts") {
                              final venues = state.venuesAt(nextLevel);
                              updateCallback.call(venues, true);
                            }
                          },
                          initOptions: Map.fromEntries(RM
                              .get<Property>()
                              .state
                              .zones()
                              .map((e) => MapEntry(e.code, e.locale))),
                          title: "選擇場館");
                    }));
                    if (venue != null) {
                      this.venue = state.venues
                          .singleWhere((element) => element.id == venue);
                      setState(() {});
                    }
                  }),
                  content: venue?.name ?? ""),
              SingleLineContentDetail(
                  label: "場地",
                  onEdit: ((context) async {
                    final newFields = await Navigator.of(context)
                        .push(MaterialPageRoute<List<String>?>(builder: (_) {
                      return MultipleTextOptionSelector(
                          initialValue: fields,
                          label: "場地編號",
                          onCancel: null,
                          title: "設定活動場地");
                    }));
                    if (newFields?.isNotEmpty ?? false) {
                      fields = newFields!;
                      setState(() {});
                    }
                    debugPrint("Fields : $newFields");
                  }),
                  content: "${fields.join(",")} (${fields.length}個場)"),
              SingleLineContentDetail(
                  label: "價錢",
                  onEdit: ((context) async {
                    final newPrice = await Navigator.of(context)
                        .push<num>(MaterialPageRoute(builder: (_) {
                      return NumberEditor(
                          numberTitle: "HKD",
                          title: "設定價錢",
                          initialValue: price.ceil());
                    }));
                    // debugPrint("newPrice : $newPrice");
                    if (newPrice != null) {
                      price = newPrice.toDouble();
                      setState(() {});
                    }
                  }),
                  content: "HK\$ ${price.ceil()}"),
              SingleLineContentDetail(
                  label: "餘位",
                  onEdit: ((context) async {
                    final newVacancy = await Navigator.of(context)
                        .push(MaterialPageRoute<num>(builder: (_) {
                      return NumberEditor(numberTitle: "人數", title: "設定餘位");
                    }));
                    // debugPrint("newPrice : $newPrice");
                    if (newVacancy != null) {
                      vacancy = newVacancy.ceil();
                      setState(() {});
                    }
                  }),
                  content: vacancy.toString()),
              SingleLineContentDetail(
                  label: "程度要求",
                  onEdit: ((context) async {
                    final newLevels = await Navigator.of(context)
                        .push<List<String>?>(MaterialPageRoute(builder: (_) {
                      return OptionsChecker(
                        initialValue: targetLevels,
                        title: "設定程度要求",
                        localeType: "badminton_level_label",
                        options: levels(ActivityType.badminton),
                        minimum: 1,
                      );
                    }));
                    if (newLevels != null) {
                      targetLevels = newLevels;
                      setState(() {});
                    }
                  }),
                  content: targetLevels.map((e) {
                    return "badminton_level_label.$e".tr();
                  }).join(", ")),
              SingleLineContentDetail(
                  label: "自訂場地規則",
                  onEdit: ((context) async {
                    final String? rules = await Navigator.of(context)
                        .push<String>(MaterialPageRoute(builder: (_) {
                      return const OptionSelector(
                          options: {"default_rule": "預設規則"}, title: "設定場地規則");
                    }));
                  }),
                  content: "預設規則"),
              MultipleLineDetail(title: "輔助設定", itemBuilder: [
                (funct) {
                  return funct("自動確認申請", () {
                    autoConfirm = !autoConfirm;
                    setState(() {});
                  },
                      trailing: Icon(Icons.check_circle,
                          size: 16,
                          color: autoConfirm ? Colors.white : Colors.white24));
                }
              ])
            ]));
  }
}
