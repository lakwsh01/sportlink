import 'package:flutter/material.dart';

class AppbarForEditor extends PreferredSize {
  final VoidCallback onDone;
  final VoidCallback onCancel;
  final String title;
  final String? trailingText;
  final bool showTrailing;
  const AppbarForEditor(
      {super.key,
      this.showTrailing = true,
      required this.title,
      this.trailingText,
      required this.onDone,
      required this.onCancel})
      : super(
            preferredSize: const Size.fromHeight(60), child: const SizedBox());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            alignment: Alignment.center,
            height: 48,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: onCancel.call,
                      child: const SizedBox(
                          width: 48,
                          child: Icon(Icons.arrow_back_ios, size: 18))),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  if (showTrailing)
                    GestureDetector(
                        onTap: onDone.call,
                        child: Container(
                            alignment: Alignment.centerRight,
                            width: 60,
                            child: Text(trailingText ?? "儲存",
                                style:
                                    Theme.of(context).textTheme.titleMedium)))
                  else
                    const SizedBox(width: 60)
                ])));
  }
}
