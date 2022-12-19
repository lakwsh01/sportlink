import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class OptionSelector extends StatefulWidget {
  final String? optionType;
  final Iterable<String> options;
  final String? defaultOption;
  final IconData? leadingIcon;
  final ValueSetter<String> onDone;
  final VoidCallback? onCancel;
  final String title;
  const OptionSelector(
      {this.defaultOption,
      this.leadingIcon,
      required this.optionType,
      required this.onCancel,
      required this.onDone,
      required this.options,
      required this.title,
      super.key});
  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  late String selected = widget.defaultOption ?? widget.options.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: widget.title,
            onDone: () {
              Navigator.of(context).pop();
              widget.onDone.call(selected);
            },
            onCancel: () {
              Navigator.of(context).pop();
              widget.onCancel?.call();
            }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
                children: widget.options.map((e) {
              return GestureDetector(
                  onTap: () {
                    selected = e;
                    setState(() {});
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(children: [
                        Expanded(
                            child: Text("genders".tr(gender: e),
                                style: Theme.of(context).textTheme.labelLarge)),
                        if (selected == e)
                          Container(
                              decoration: const BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                              padding: const EdgeInsets.all(2),
                              child: const Material(
                                  shape: CircleBorder(),
                                  child: Icon(Icons.circle,
                                      color: Colors.white, size: 10)))
                      ])));
            }).toList())));
  }
}
