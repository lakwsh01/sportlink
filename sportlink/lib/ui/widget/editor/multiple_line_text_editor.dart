import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:uuid/uuid.dart';
import 'package:sportlink/service/converter/converter.dart';

class MultipleTextOptionSelector extends StatefulWidget {
  final String title;
  final String label;
  final VoidCallback? onCancel;
  final ValueSetter<List<String>>? onDone;
  final List<String>? initialValue;

  const MultipleTextOptionSelector(
      {this.onCancel,
      this.onDone,
      required this.label,
      required this.title,
      this.initialValue,
      super.key});

  @override
  State<MultipleTextOptionSelector> createState() =>
      _MultipleTextOptionSelectorState();
}

class _MultipleTextOptionSelectorState
    extends State<MultipleTextOptionSelector> {
  late final List<String> lines = widget.initialValue ?? [];

  Future<String?> get newSelectedOption async {
    return showModalBottomSheet<String?>(
        context: context,
        builder: (_) {
          return DuoModeOptionPicker(labels: {
            "transition_label": ["字母", "數字"]
          }, options: const [
            fieldsNumeric,
            fieldsChart
          ]);
        });
    // debugPrint("selection::: $selection");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: widget.title,
            onDone: () {
              Navigator.of(context).pop(lines);
            },
            onCancel: () {
              Navigator.of(context).pop(null);
            }),
        body: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: lines.length + 1,
            itemBuilder: ((context, index) {
              if (index == lines.length) {
                return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: TextButton.icon(
                        icon: const Icon(Icons.add, size: 14),
                        onPressed: () async {
                          final newOption = await newSelectedOption;
                          if (newOption != null) {
                            lines.add(newOption);
                            setState(() {});
                          }
                        },
                        label: const Text("增加")));
              } else {
                return Dismissible(
                    key: Key(const Uuid().v4()),
                    onDismissed: (direction) {
                      lines.remove(lines.elementAt(index));
                    },
                    child: GestureDetector(
                        onTap: () async {
                          final newOption = await newSelectedOption;
                          if (newOption != null) {
                            lines.replaceRange(index, index + 1, [newOption]);
                            setState(() {});
                          }
                        },
                        child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 100,
                                      child: Text(widget.label,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge)),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.5, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.white,
                                          border: Border.all()),
                                      child: Text(lines.elementAt(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900)))
                                ]))));
              }
            })));
  }
}

class DuoModeOptionPicker extends StatefulWidget {
  final int initiateValue;
  final int initiateMode;
  final List<List<String>> options;
  final Map<String, List<String>> labels;

  DuoModeOptionPicker(
      {this.initiateMode = 0,
      this.initiateValue = 0,
      required this.options,
      required this.labels,
      super.key})
      : assert(options.length != labels.length,
            throw ArgumentError("options length != labels length"));

  @override
  State<DuoModeOptionPicker> createState() => _DuoModeOptionPickerState();
}

class _DuoModeOptionPickerState extends State<DuoModeOptionPicker> {
  late int mode = widget.initiateMode;
  late final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: widget.initiateValue);

  String get transitionLabel {
    if (mode == 0) {
      return widget.labels["transition_label"]?.first ?? "";
    } else {
      return widget.labels["transition_label"]?.last ?? "";
    }
  }

  List<String> get options {
    if (mode == 0) {
      return widget.options.first;
    } else {
      return widget.options.last;
    }
  }

  String get selected {
    if (mode == 0) {
      return widget.options.first.elementAt(controller.selectedItem);
    } else {
      return widget.options.last.elementAt(controller.selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = this.options;

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              if (mode == 0) {
                mode = 1;
              } else {
                mode = 0;
              }
              debugPrint("OPTIONS MODE: $mode");
              setState(() {});
              controller.jumpTo(0);
            },
            child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                child: Row(children: [
                  const Icon(Icons.translate, size: 14),
                  const SizedBox(width: 10),
                  Text(transitionLabel)
                ]))),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop(selected);
            },
            child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                child: Text("DONE",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.w700)))),
      ]),
      Expanded(
          child: CupertinoPicker(
              scrollController: controller,
              itemExtent: 24,
              squeeze: 1.2,
              onSelectedItemChanged: (d) {},
              children: options
                  .map((e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(e, style: TextStyle(fontSize: 24))))
                  .toList()))
    ]);
  }
}
