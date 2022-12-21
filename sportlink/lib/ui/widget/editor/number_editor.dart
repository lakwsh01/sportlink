import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class NumberEditor extends StatelessWidget {
  final String title;
  final String numberTitle;
  final num? initialValue;
  NumberEditor(
      {required this.numberTitle,
      this.initialValue,
      required this.title,
      super.key});

  late final TextEditingController controller =
      TextEditingController(text: (initialValue ?? "").toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: title,
            onDone: () {
              final price = num.tryParse(controller.text);
              Navigator.of(context).pop(price);
            },
            onCancel: () {
              Navigator.of(context).pop(null);
            }),
        body: Column(children: [
          const SizedBox(height: 12),
          Text(numberTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(height: 1.1, color: Colors.white24)),
          TextField(
              textAlign: TextAlign.center,
              showCursor: false,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(height: 1.1),
              decoration: const InputDecoration(border: InputBorder.none),
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.number)
        ]));
  }
}
