import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showDatetimePicker(BuildContext context, String title, String buttonLabel,
    ValueSetter<DateTime> onComplete, DateTime minDt,
    [DateTime? inititalDt]) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        DateTime value = inititalDt ?? minDt.add(const Duration(days: 2));
        return Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: [
                Expanded(child: Text(title)),
                TextButton(
                    onPressed: () => onComplete.call(value),
                    child: Text(buttonLabel))
              ])),
          Expanded(
              child: CupertinoDatePicker(
                  minimumDate: minDt,
                  minuteInterval: 30,
                  initialDateTime: value,
                  use24hFormat: true,
                  onDateTimeChanged: (dt) {
                    value = dt;
                  }))
        ]);
      });
}
