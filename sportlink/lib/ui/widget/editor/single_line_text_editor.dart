import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class SingleLineTextContentEditor extends StatelessWidget {
  final TextEditingController controller;
  final IconData? leadingIcon;
  final VoidCallback onDone;
  final VoidCallback? onCancel;
  final String title;
  const SingleLineTextContentEditor(
      {required this.onCancel,
      required this.onDone,
      this.leadingIcon,
      required this.controller,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: title,
            onDone: () {
              Navigator.of(context).pop();
              onDone.call();
            },
            onCancel: () {
              Navigator.of(context).pop();
              onCancel?.call();
            }),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              TextField(autofocus: true, controller: controller),
            ])));
  }
}
