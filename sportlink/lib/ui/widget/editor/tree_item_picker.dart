import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/static/content/equments/badminton/shuttlecocks.dart';

class TreeItemPicker extends StatefulWidget {
  const TreeItemPicker({super.key});

  @override
  State<TreeItemPicker> createState() => _TreeItemPickerState();
}

class _TreeItemPickerState extends State<TreeItemPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Row(children: [
        Expanded(
            child: CupertinoPicker(
                itemExtent: 20,
                onSelectedItemChanged: (s) {},
                children: shuttlecocks.keys.map((e) => Text(e)).toList())),
        Expanded(
            child: CupertinoPicker(
                itemExtent: 20,
                onSelectedItemChanged: (s) {},
                children: shuttlecocks.values
                    .expand((element) => element)
                    .map((e) => Text(e))
                    .toList()))
      ]))
    ]);
  }
}
