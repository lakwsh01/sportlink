// import 'package:com_goodtakes/service/convertor/int.dart';
// import 'package:com_goodtakes/static/standard_styling/standard_button_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';


// class LinerTimeRange12HourPicker extends StatefulWidget {
//   final TimeOfDay? anchorDT;
//   final int deltaInHour;
//   final int interval;
//   final String title;
//   final String trialling;
//   final Decoration? decoration;
//   final Clip clipBehaveiour;
//   final EdgeInsets margin;
//   final bool centerTitle;
//   final EdgeInsets titlePadding;

//   const LinerTimeRange12HourPicker(
//       {this.title = "提取時間由 ",
//       this.centerTitle = true,
//       this.trialling = " 開始",
//       this.interval = 15,
//       this.deltaInHour = 0,
//       this.anchorDT,
//       this.decoration,
//       this.clipBehaveiour = Clip.antiAlias,
//       this.margin = const EdgeInsets.all(10),
//       this.titlePadding = const EdgeInsets.only(top: 19),
//       Key? key})
//       : super(key: key);

//   @override
//   _LinerTimeRange12HourPickerState createState() =>
//       _LinerTimeRange12HourPickerState();
// }

// class _LinerTimeRange12HourPickerState
//     extends State<LinerTimeRange12HourPicker> {
//   late TimeOfDay anchorDT = widget.anchorDT ?? TimeOfDay.now();
//   late int durationInMinute = 0;

//   late final List<int> availableHourOfDay;
//   late final intervalCount = (60 / widget.interval).ceil();
//   late final standardIntervals =
//       List.generate(intervalCount, (index) => index * widget.interval);

//   void initAvailableHours() {
//     final currentHour = anchorDT.hour;
//     if (currentHour > 12) {
//       availableHourOfDay = List.generate(length, (index) => null);
//     }

//     if (anchorDT.minute >= standardIntervals.last) {
//       availableHourOfDay = List.generate(
//           count, (index) => (index + anchorDT.hour + (widget.deltaInHour) + 1));
//     } else {
//       // debugPrint("anchorDT.minute >= standardIntervals.last false");
//       availableHourOfDay = List.generate(count + 1,
//           (index) => (index + anchorDT.hour + (widget.deltaInHour))).toList();
//     }

//     availableHourOfDay.removeWhere((element) => element > 24);
//   }

//   late final int currentHourSelection = availableHourOfDay.length > 2
//       ? availableHourOfDay[2]
//       : availableHourOfDay.first;
//   late final int currentIntervalSelection = 0;
//   late final int currentSegmentSelection =
//       availableHourOfDay.first >= 12 ? 0 : 1;

//   late final FixedExtentScrollController hourController =
//       FixedExtentScrollController(initialItem: currentHourSelection);
//   late final FixedExtentScrollController intervalController =
//       FixedExtentScrollController(initialItem: currentIntervalSelection);
//   late final FixedExtentScrollController segmentController =
//       FixedExtentScrollController(initialItem: currentSegmentSelection);

//   List<int> get availableInterval {
//     final selected = currentHourSelection;
//     if (selected == 24) {
//       return [0];
//     } else if (selected == (anchorDT.hour + (widget.deltaInHour))) {
//       final _intervals = List<int>.from(standardIntervals);
//       _intervals.removeWhere(
//           (element) => anchorDT.minute > element || anchorDT.minute == element);

//       return _intervals;
//     } else {
//       return standardIntervals;
//     }
//   }

//   List<String> get availableSegment {
//     if (currentHourSelection) return ["AM", "PM"];
//   }

//   String get currentHourSelectionDisplay {
//     return IntFormator.toStringAsFixedDigit(value: currentHourSelection);
//   }

//   String get currentIntervalSelectionDisplay {
//     return IntFormator.toStringAsFixedDigit(value: currentIntervalSelection);
//   }

//   String get currentSegmentSelectionDisplay {
//     return availableSegment.elementAt(currentSegmentSelection);
//   }

//   @override
//   void initState() {
//     initAvailableHours();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     hourController.dispose();
//     intervalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Container(
//           alignment:
//               widget.centerTitle ? Alignment.center : Alignment.centerLeft,
//           padding: widget.titlePadding,
//           child: RichText(
//               text: TextSpan(
//                   style: const TextStyle(color: Colors.black, fontSize: 16),
//                   children: [
//                 TextSpan(text: widget.title),
//                 TextSpan(
//                     text: currentHourSelectionDisplay,
//                     style: const TextStyle(
//                         color: Colors.orange, fontWeight: FontWeight.bold)),
//                 const TextSpan(
//                     text: " : ",
//                     style: TextStyle(
//                         color: Colors.orange, fontWeight: FontWeight.bold)),
//                 TextSpan(
//                     text: currentIntervalSelectionDisplay,
//                     style: const TextStyle(
//                         color: Colors.orange, fontWeight: FontWeight.bold)),
//                 TextSpan(
//                     text: " " + currentSegmentSelectionDisplay,
//                     style: const TextStyle(
//                         color: Colors.orange, fontWeight: FontWeight.bold)),
//                 TextSpan(text: widget.trialling),
//               ]))),
//       Expanded(
//           child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 12),
//               child: Row(children: [
//                 Expanded(
//                     child: CupertinoPicker(
//                         itemExtent: _itemExtent,
//                         offAxisFraction: _offAxisFraction,
//                         diameterRatio: _diameterRatio,
//                         squeeze: _squeeze,
//                         scrollController: hourController,
//                         selectionOverlay:
//                             const CupertinoPickerDefaultSelectionOverlay(
//                           capLeftEdge: false,
//                           capRightEdge: false,
//                         ),
//                         children: availableHourOfDay
//                             .map((e) => Text(
//                                 IntFormator.toStringAsFixedDigit(value: e)))
//                             .toList(),
//                         onSelectedItemChanged: (value) {
//                           // currentHourSelection =
//                           //     availableHourOfDay.elementAt(value);
//                           // // debugPrint(
//                           // //     "currentHourSelection : $currentHourSelection");
//                           // if (currentHourSelection ==
//                           //         availableHourOfDay.first ||
//                           //     currentHourSelection == 24) {
//                           //   intervalController.jumpToItem(0);
//                           //   currentIntervalSelection =
//                           //       this.availableInterval.first;
//                           // }
//                           // setState(() {});
//                         })),
//                 Expanded(
//                     child: CupertinoPicker(
//                   itemExtent: _itemExtent,
//                   diameterRatio: _diameterRatio,
//                   offAxisFraction: _offAxisFraction,
//                   squeeze: _squeeze,
//                   scrollController: intervalController,
//                   selectionOverlay:
//                       const CupertinoPickerDefaultSelectionOverlay(
//                     capLeftEdge: false,
//                     capRightEdge: false,
//                   ),
//                   children: availableInterval
//                       .map((e) =>
//                           Text(IntFormator.toStringAsFixedDigit(value: e)))
//                       .toList(),
//                   onSelectedItemChanged: (value) {
//                     // currentIntervalSelection =
//                     //     availableInterval.elementAt(value);
//                     // setState(() {});
//                   },
//                 )),
//                 Expanded(
//                     child: CupertinoPicker(
//                   itemExtent: _itemExtent,
//                   diameterRatio: _diameterRatio,
//                   squeeze: _squeeze,
//                   offAxisFraction: _offAxisFraction,
//                   scrollController: segmentController,
//                   selectionOverlay:
//                       const CupertinoPickerDefaultSelectionOverlay(
//                     capLeftEdge: false,
//                     capRightEdge: false,
//                   ),
//                   children: availableSegment.map((e) => Text(e)).toList(),
//                   onSelectedItemChanged: (value) {
//                     // currentSegmentSelection = value;
//                   },
//                 ))
//               ]))),
//       const SizedBox(height: 12),
//       Row(
//         children: [
//           Expanded(
//               child: ElevatedButton(
//                   style: StandardButtonStyle
//                       .linearTimeRangePickerCancelButtonStyle,
//                   onPressed: () {
//                     Navigator.of(context).pop(null);
//                   },
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [Text("取消")]))),
//           Expanded(
//               child: ElevatedButton(
//                   style: StandardButtonStyle
//                       .linearTimeRangePickerConfirmButtonStyle,
//                   onPressed: () {
//                     debugPrint("currentHourSelection");
//                     Navigator.of(context).pop(TimeOfDay(
//                       hour: availableHourOfDay
//                           .elementAt(hourController.selectedItem),
//                       minute: availableInterval
//                           .elementAt(hourController.selectedItem),
//                     ));
//                   },
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [Text("確定")])))
//         ],
//       )
//     ]));
//   }
// }
