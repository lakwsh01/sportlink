import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/demo/venu.dart';
import 'package:sportlink/model/models/base/db_key.dart';
import 'package:sportlink/model/models/veneu.dart';
import 'package:sportlink/service/converter/converter.dart';
import 'package:sportlink/state/property.dart';
import 'package:sportlink/static/style/standard_player_level.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:sportlink/ui/widget/editor/option_selector.dart';
import 'package:sportlink/ui/widget/editor/venue_selector.dart';
import 'package:sportlink/ui/widget/editor/multiple_line_text_editor.dart';
import 'package:sportlink/ui/widget/editor/number_editor.dart';
import 'package:sportlink/ui/widget/editor/options_checker.dart';
import 'package:sportlink/ui/widget/editor/single_line_text_editor.dart';
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
  List<String> targetLevels = ["hk_0", "hk_1", "hk_2"];
  double price = 50;
  int vacancy = 0;
  bool autoConfirm = true;

  String get localeType {
    return "badminton_level_label";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: "發佈活動場次",
            trailingText: "發佈",
            onDone: () {
              debugPrint("Publish");
            },
            onCancel: () {}),
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
                    // final Venue? newFields = await Navigator.of(context)
                    //     .push(MaterialPageRoute<Venue>(builder: (_) {
                    //   return OptionSelector(
                    //       maxLevel: 3,
                    //       onNextLevel: (String nextLevel) {},
                    //       onConfirm: (String option) {},
                    //       initOptions: RM.get<Property>().state.zone(),
                    //       title: "title");
                    // }));
                  }),
                  content: "摩士公園體育館"),
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
                  label: "活動餘位",
                  onEdit: ((context) async {
                    final newVacancy = await Navigator.of(context)
                        .push(MaterialPageRoute<num>(builder: (_) {
                      return NumberEditor(
                          numberTitle: "人數",
                          title: "設定餘位",
                          initialValue: vacancy);
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
                        minimum: 0,
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

class MultipleLineDetail extends StatelessWidget {
  final String title;
  // final List<Widget> items;
  final List<
      Widget Function(
          Widget Function(String label, VoidCallback onEdit,
              {Widget? trailing}))> itemBuilder;

  const MultipleLineDetail(
      {
      // required this.items,
      required this.itemBuilder,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 100,
          child: Text(title, style: Theme.of(context).textTheme.labelLarge)),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemBuilder.map((e) {
                final Widget widget = e((label, onEdit, {trailing}) {
                  return GestureDetector(
                      onTap: onEdit,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.white))),
                              child: trailing == null
                                  ? Text(label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge)
                                  : Row(children: [
                                      Expanded(
                                          child: Text(label,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge)),
                                      trailing
                                    ]))));
                });
                return widget;
              }).toList()))
    ]);
  }
}

class SingleLineContentDetail extends StatelessWidget {
  final String label;
  final String content;
  final Key? formKey;
  final void Function(BuildContext context)? onEdit;
  const SingleLineContentDetail(
      {required this.label,
      required this.onEdit,
      this.formKey,
      required this.content,
      super.key});

  factory SingleLineContentDetail.text(final String label, final String content,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            final TextEditingController controller =
                TextEditingController(text: content);
            return SingleLineTextContentEditor(
                onCancel: null,
                onDone: () {
                  onEditComplete?.call(controller.text);
                },
                controller: controller,
                title: label);
          }));
        },
        label: label,
        content: content);
  }

  factory SingleLineContentDetail.phone(
      final String label, final String content,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {}, label: label, content: content);
  }
  factory SingleLineContentDetail.option(final String label,
      final String defaultOption, final String optionType, List<String> options,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {},
        label: label,
        content: optionType.tr(gender: defaultOption));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onEdit?.call(context),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: 100,
                  child: Text(label,
                      style: Theme.of(context).textTheme.labelLarge)),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.2, color: Colors.white))),
                      child: Text(content,
                          style: Theme.of(context).textTheme.labelLarge)))
            ])));
  }
}

void showDatetimePicker(BuildContext context, String title, String buttonLabel,
    ValueSetter<DateTime> onComplete, DateTime minDt,
    [DateTime? inititalDt]) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        DateTime value = inititalDt ?? minDt.add(const Duration(days: 2));
        return Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: [
                Expanded(child: Text(title)),
                TextButton(
                    onPressed: () => onComplete.call(value),
                    child: Text(buttonLabel))
              ])),
          Expanded(
              child: CupertinoDatePicker(
                  minimumDate: minDt,
                  minuteInterval: 30,
                  initialDateTime: value,
                  use24hFormat: true,
                  onDateTimeChanged: (dt) {
                    value = dt;
                  }))
        ]);
      });
}
