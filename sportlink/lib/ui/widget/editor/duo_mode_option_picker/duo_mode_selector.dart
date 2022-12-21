import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/static/content/local.dart';
import 'package:sportlink/ui/widget/editor/duo_mode_option_picker/options.dart';

const _locale = "duo_mode_option_picker";

class DuoModeOptionPicker extends StatefulWidget {
  final int? initiateValue;
  final DuoModePickerOptionType? initialMode;
  final List<DuoModePickerOptionType>? modes;

  const DuoModeOptionPicker(
      {this.initialMode, this.initiateValue, this.modes, super.key});

  @override
  State<DuoModeOptionPicker> createState() => _DuoModeOptionPickerState();
}

class _DuoModeOptionPickerState extends State<DuoModeOptionPicker> {
  late final List<DuoModePickerOptionType> modes =
      widget.modes ?? DuoModePickerOptionType.values;
  late DuoModePickerOptionType mode = widget.initialMode ?? modes.first;
  late final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: widget.initiateValue ?? 0);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              if (mode == modes.first) {
                mode = modes.last;
              } else {
                mode = modes.first;
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
                  Text(mode.keyboardTypeLabel)
                ]))),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop(mode.item(controller.selectedItem));
            },
            child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(12),
                alignment: Alignment.centerRight,
                child: Text(LocaleInitial.genericButtonLabel.labelAt("done"),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.w700)))),
      ]),
      Expanded(
          child: CupertinoPicker(
              scrollController: controller,
              itemExtent: 30,
              squeeze: 0.8,
              onSelectedItemChanged: (d) {},
              children: mode.options
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Text(e.toUpperCase(),
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center)))
                  .toList()))
    ]);
  }
}
