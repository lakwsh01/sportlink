import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:sportlink/ui/widget/editor/duo_mode_option_picker/duo_mode_selector.dart';
import 'package:uuid/uuid.dart';

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
          return const DuoModeOptionPicker();
        });
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
                                      child: Text(
                                          lines.elementAt(index).toUpperCase(),
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
