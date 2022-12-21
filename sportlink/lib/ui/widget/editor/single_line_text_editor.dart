import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class SingleLineTextContentEditor extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? leadingIcon;
  final ValueSetter<String>? onDone;
  final VoidCallback? onCancel;
  final String title;
  const SingleLineTextContentEditor(
      {this.onCancel,
      this.onDone,
      this.leadingIcon,
      this.controller,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = controller ?? TextEditingController();
    return Scaffold(
        appBar: AppbarForEditor(
            title: title,
            onDone: () {
              Navigator.of(context).pop(_controller.text);
              onDone?.call(_controller.text);
            },
            onCancel: () {
              Navigator.of(context).pop();
              onCancel?.call();
            }),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              TextField(autofocus: true, controller: _controller),
            ])));
  }
}
