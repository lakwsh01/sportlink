import 'package:flutter/material.dart';

class AppbarWithTitle extends PreferredSize {
  final String title;
  final bool leadingActive;
  final Widget? leading;
  const AppbarWithTitle(
      {super.key, this.leadingActive = true, this.leading, required this.title})
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
                  if (leading != null)
                    leading!
                  else if (leadingActive)
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const SizedBox(
                            width: 48,
                            child: Icon(Icons.arrow_back_ios, size: 18))),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  if (leadingActive) const SizedBox(width: 48)
                ])));
  }
}
