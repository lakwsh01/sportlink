import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/editor/single_line_text_editor.dart';

class SingleLineContentDetail extends StatelessWidget {
  final String label;
  final String content;
  final Key? formKey;
  final void Function(BuildContext context)? onEdit;
  const SingleLineContentDetail(
      {required this.label,
      required this.onEdit,
      this.formKey,
      required this.content,
      super.key});

  factory SingleLineContentDetail.text(final String label, final String content,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return SingleLineTextContentEditor(
                onCancel: null, onDone: onEditComplete, title: label);
          }));
        },
        label: label,
        content: content);
  }

  factory SingleLineContentDetail.phone(
      final String label, final String content,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {}, label: label, content: content);
  }
  factory SingleLineContentDetail.option(final String label,
      final String defaultOption, final String optionType, List<String> options,
      [final ValueSetter<String>? onEditComplete, final Key? key]) {
    return SingleLineContentDetail(
        onEdit: (BuildContext context) {},
        label: label,
        content: optionType.tr(gender: defaultOption));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onEdit?.call(context),
        child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: 100,
                  child: Text(label,
                      style: Theme.of(context).textTheme.labelLarge)),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.2, color: Colors.white))),
                      child: Text(content,
                          style: Theme.of(context).textTheme.labelLarge)))
            ])));
  }
}
