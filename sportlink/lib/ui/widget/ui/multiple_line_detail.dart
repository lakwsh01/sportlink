import 'package:flutter/material.dart';

class MultipleLineDetail extends StatelessWidget {
  final String title;
  // final List<Widget> items;
  final List<
      Widget Function(
          Widget Function(String label, VoidCallback onEdit,
              {Widget? trailing}))> itemBuilder;

  const MultipleLineDetail(
      {
      // required this.items,
      required this.itemBuilder,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 100,
          child: Text(title, style: Theme.of(context).textTheme.labelLarge)),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: itemBuilder.map((e) {
                final Widget widget = e((label, onEdit, {trailing}) {
                  return GestureDetector(
                      onTap: onEdit,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.white))),
                              child: trailing == null
                                  ? Text(label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge)
                                  : Row(children: [
                                      Expanded(
                                          child: Text(label,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge)),
                                      trailing
                                    ]))));
                });
                return widget;
              }).toList()))
    ]);
  }
}
