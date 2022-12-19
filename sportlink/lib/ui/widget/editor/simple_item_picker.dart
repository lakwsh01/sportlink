import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleItemPicker extends StatelessWidget {
  const SimpleItemPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: CupertinoPicker(
              itemExtent: 2,
              onSelectedItemChanged: (con) {},
              children: List.generate(999, (index) {
                return Text(index.toString());
              })))
    ]));
  }
}
