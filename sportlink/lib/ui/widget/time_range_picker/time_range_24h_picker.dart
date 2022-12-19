import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/service/converter/converter.dart';

const _squeeze = 1.0;
const _itemExtent = 24.0;
const _offAxisFraction = 0.0;
const _diameterRatio = 1.0;

Future<TimeOfDay?> showLinerTimePicker(
  BuildContext context,
  String title, {
  TimeOfDay? anchorDT,
  int deltaInHour = 0,
  int interval = 15,
  TimeOfDay? maxmium,
  List<int>? manuallyRemove,
  List<int>? manuallyRejectInterval,
}) async {
  return await showDialog<TimeOfDay?>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(48),
            child: Material(
                child: SizedBox(
                    height: 257,
                    width: 246,
                    child: LinerTimeRange24HourPicker(
                        manuallyRemove: manuallyRemove,
                        manuallyRejectInterval: manuallyRejectInterval,
                        title: title,
                        maxmium: maxmium,
                        anchorDT: anchorDT,
                        deltaInHour: deltaInHour,
                        interval: interval,
                        margin: EdgeInsets.zero))));
      });
}

class LinerTimeRange24HourPicker extends StatefulWidget {
  final TimeOfDay? anchorDT;
  final int deltaInHour;
  final int interval;
  final String title;
  final List<int>? manuallyRemove;
  final List<int>? manuallyRejectInterval;
  final Decoration? selectorDecoration;
  final Clip clipBehaveiour;
  final EdgeInsets margin;
  final bool centerTitle;
  final EdgeInsets titlePadding;
  final EdgeInsets selectorMargin;
  final TimeOfDay? maxmium;
  final List<Widget>? actions;
  final bool showTitle;
  final ValueSetter<DateTime>? onChange;

  const LinerTimeRange24HourPicker(
      {this.title = "時間",
      this.interval = 15,
      this.showTitle = true,
      this.manuallyRemove,
      this.manuallyRejectInterval,
      this.deltaInHour = 0,
      this.selectorMargin =
          const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      this.maxmium,
      this.anchorDT,
      this.selectorDecoration = const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      this.clipBehaveiour = Clip.antiAlias,
      this.margin = const EdgeInsets.all(10),
      this.centerTitle = true,
      this.titlePadding = const EdgeInsets.only(top: 19),
      this.actions,
      this.onChange,
      Key? key})
      : super(key: key);

  @override
  LinerTimeRange24HourPickerState createState() =>
      LinerTimeRange24HourPickerState();
}

class LinerTimeRange24HourPickerState
    extends State<LinerTimeRange24HourPicker> {
  int? get maxiumHour {
    final hh = widget.maxmium?.hour;
    final mn = widget.maxmium?.minute;

    if (hh == null || mn == null) {
      // debugPrint(" maxiumHour null hh: $hh .. mn $mn");
      return null;
    } else if (mn > 0) {
      // debugPrint(" hh + 1 ::: ${hh + 1}");
      return hh + 1;
    } else {
      // debugPrint(" hh  ::: $hh");
      return hh;
    }
  }

  late TimeOfDay anchorDT = widget.anchorDT ?? TimeOfDay.now();
  late int durationInMinute = 0;

  late final List<int> availableHourOfDay;
  late final intervalCount = (60 / widget.interval).ceil();
  late final standardIntervals =
      List.generate(intervalCount, (index) => index * widget.interval);

  void initAvailableHours() {
    final count = 24 - anchorDT.hour;
    if (anchorDT.minute >= standardIntervals.last) {
      availableHourOfDay = List.generate(
          count, (index) => (index + anchorDT.hour + (widget.deltaInHour) + 1));
    } else {
      // debugPrint("anchorDT.minute >= standardIntervals.last false");
      availableHourOfDay = List.generate(count + 1,
          (index) => (index + anchorDT.hour + (widget.deltaInHour))).toList();
    }
    if ((widget.manuallyRemove?.isNotEmpty ?? false)) {
      availableHourOfDay
          .removeWhere((element) => widget.manuallyRemove!.contains(element));
    }
    final maxiumHour = this.maxiumHour ?? 99;
    availableHourOfDay
        .removeWhere((element) => element > 24 || element > maxiumHour);
    currentIntervalSelection = standardIntervals.first;
  }

  late int currentHourSelection = availableHourOfDay.length > 2
      ? availableHourOfDay[2]
      : availableHourOfDay.first;
  late int currentIntervalSelection;

  TimeOfDay get currentSelectionTOD {
    return TimeOfDay(
        hour: currentHourSelection, minute: currentIntervalSelection);
  }

  DateTime get currentSelectionDT {
    final dt = DateTime.now().copyWith(
        hour: currentHourSelection,
        minute: currentIntervalSelection,
        microsecond: 0,
        millisecond: 0);
    return dt;
  }

  List<int> get availableInterval {
    // debugPrint(
    //     "currentHourSelection : $currentHourSelection , manuallyRejectInterval: ${widget.manuallyRejectInterval}");
    if ((widget.manuallyRejectInterval?.contains(currentHourSelection) ??
        false)) {
      return [0];
    } else if (currentHourSelection == (anchorDT.hour + (widget.deltaInHour))) {
      final _intervals = List<int>.from(standardIntervals);
      // debugPrint("intervals : $_intervals");
      _intervals.removeWhere((element) {
        // debugPrint("anchorDT.minute > element ${anchorDT.minute > element}");
        return anchorDT.minute > element;
        // || anchorDT.minute == element;
      });

      return _intervals;
    } else {
      return standardIntervals;
    }
  }

  final hourController = FixedExtentScrollController(initialItem: 2);
  final intervalController = FixedExtentScrollController(initialItem: 0);

  @override
  void initState() {
    initAvailableHours();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.onChange?.call(currentSelectionDT);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    hourController.dispose();
    intervalController.dispose();
    super.dispose();
  }

  List<String> get titles {
    return widget.title.split(textSpliter);
  }

  @override
  Widget build(BuildContext context) {
    final availableInterval = this.availableInterval;
    final _titles = titles;
    return Material(
        color: Colors.transparent,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.showTitle)
                Container(
                    alignment: widget.centerTitle
                        ? Alignment.center
                        : Alignment.centerLeft,
                    padding: widget.titlePadding,
                    child: RichText(
                        textAlign: widget.centerTitle
                            ? TextAlign.center
                            : TextAlign.start,
                        text: TextSpan(
                            style: Theme.of(context).textTheme.headline6,
                            children: [
                              TextSpan(text: _titles.first),
                              TextSpan(
                                  text:
                                      "${IntMethod.toStringAsFixedDigit(value: currentHourSelection)} : ${IntMethod.toStringAsFixedDigit(value: currentIntervalSelection)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.copyWith(color: Colors.orange)),
                              TextSpan(text: _titles.last),
                            ]))),
              Container(
                  height: 275,
                  margin: widget.selectorMargin,
                  child: Row(children: [
                    Expanded(
                        child: CupertinoPicker(
                            itemExtent: _itemExtent,
                            diameterRatio: _diameterRatio,
                            offAxisFraction: _offAxisFraction,
                            squeeze: _squeeze,
                            scrollController: hourController,
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(
                                    capStartEdge: false, capEndEdge: false),
                            children: availableHourOfDay
                                .map((e) => Text(
                                    IntMethod.toStringAsFixedDigit(value: e)))
                                .toList(),
                            onSelectedItemChanged: (value) {
                              currentHourSelection =
                                  availableHourOfDay.elementAt(value);
                              // debugPrint(
                              //     "currentHourSelection : $currentHourSelection");
                              if (currentHourSelection ==
                                      availableHourOfDay.first ||
                                  currentHourSelection == 24) {
                                intervalController.jumpToItem(0);
                                currentIntervalSelection =
                                    this.availableInterval.first;
                              }
                              setState(() {});
                              widget.onChange?.call(currentSelectionDT);
                            })),
                    // Container(
                    //     decoration: const BoxDecoration(
                    //         color: CupertinoColors.tertiarySystemFill),
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 12, vertical: 4),
                    //     child: const Text(":")),
                    Expanded(
                        child: CupertinoPicker(
                            backgroundColor: Colors.transparent,
                            itemExtent: _itemExtent,
                            diameterRatio: _diameterRatio,
                            offAxisFraction: _offAxisFraction,
                            squeeze: _squeeze,
                            scrollController: intervalController,
                            selectionOverlay:
                                const CupertinoPickerDefaultSelectionOverlay(
                                    capStartEdge: false, capEndEdge: false),
                            children: availableInterval
                                .map((e) => Text(
                                    IntMethod.toStringAsFixedDigit(value: e)))
                                .toList(),
                            onSelectedItemChanged: (value) {
                              currentIntervalSelection =
                                  availableInterval.elementAt(value);
                              setState(() {});

                              widget.onChange?.call(currentSelectionDT);
                            }))
                  ])),
              const SizedBox(height: 12),
              if (widget.actions == null)
                Row(children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [Text("取消")]))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            debugPrint("currentHourSelection");
                            Navigator.of(context).pop(TimeOfDay(
                                hour: currentHourSelection,
                                minute: currentIntervalSelection));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [Text("確定")])))
                ])
              else
                Row(children: widget.actions!)
            ]));
  }
}
