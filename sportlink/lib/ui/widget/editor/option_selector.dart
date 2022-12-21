import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class OptionSelector extends StatefulWidget {
  final Map<String, String> options;
  final String? defaultOption;
  final IconData? leadingIcon;
  final ValueSetter<String>? onDone;
  final VoidCallback? onCancel;
  final String title;
  final Widget? bottom;
  const OptionSelector(
      {this.defaultOption,
      this.leadingIcon,
      this.onCancel,
      this.onDone,
      required this.options,
      required this.title,
      this.bottom,
      super.key});
  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  late String selected = widget.defaultOption ?? widget.options.keys.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: widget.title,
            onDone: () {
              Navigator.of(context).pop<String>(selected);
              widget.onDone?.call(selected);
            },
            onCancel: () {
              Navigator.of(context).pop();
              widget.onCancel?.call();
            }),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: widget.options.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  itemBuilder: ((context, index) {
                    final value = widget.options.entries.elementAt(index);
                    return GestureDetector(
                        onTap: () {
                          selected = value.key;
                          setState(() {});
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(children: [
                              Expanded(
                                  child: Text(value.value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge)),
                              if (selected == value.key)
                                Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(2),
                                    child: const Material(
                                        shape: CircleBorder(),
                                        child: Icon(Icons.circle,
                                            color: Colors.white, size: 10)))
                            ])));
                  }))),
          if (widget.bottom != null) widget.bottom!
        ]));
  }
}
