import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class OptionsChecker extends StatefulWidget {
  final int? maximun;
  final int minimum;
  final String title;
  final String localeType;

  final List<String> options;
  final List<String>? initialValue;

  const OptionsChecker(
      {required this.title,
      required this.localeType,
      required this.minimum,
      required this.options,
      this.initialValue,
      this.maximun,
      super.key});

  @override
  State<OptionsChecker> createState() => _OptiosnCheckerState();
}

class _OptiosnCheckerState extends State<OptionsChecker> {
  late final selectedOptions = widget.initialValue ?? <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: widget.title,
            onDone: () {
              Navigator.of(context).pop(selectedOptions);
            },
            onCancel: () {
              Navigator.of(context).pop(null);
            }),
        body: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: widget.options.length,
            itemBuilder: ((context, index) {
              final String option = widget.options.elementAt(index);
              final String description =
                  "${widget.localeType}.${option}_description".tr();

              return GestureDetector(
                  onTap: () async {
                    if (selectedOptions.contains(option)) {
                      selectedOptions.remove(option);
                    } else {
                      selectedOptions.add(option);
                    }
                    setState(() {});
                  },
                  child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                                selectedOptions.contains(option)
                                    ? Icons.check_circle
                                    : Icons.circle,
                                color: selectedOptions.contains(option)
                                    ? Colors.white
                                    : Colors.white12,
                                size: 20),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 12),
                                width: 100,
                                height: 50,
                                child: Text(
                                    widget.localeType.tr(
                                        gender:
                                            widget.options.elementAt(index)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge)),
                            if (!description.contains(widget.localeType))
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 12),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white54,
                                                  width: 1))),
                                      child: Text(description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge)))
                            else
                              Expanded(child: Container())
                          ])));
            })));
  }
}
