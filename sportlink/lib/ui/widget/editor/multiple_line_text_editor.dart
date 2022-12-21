import 'package:flutter/material.dart';
import 'package:sportlink/static/content/local.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:sportlink/ui/widget/editor/single_line_text_editor.dart';
import 'package:uuid/uuid.dart';

class MultipleLineTextEditor extends StatefulWidget {
  final IconData? leadingIcon;
  final List<String>? initialDatas;
  final VoidCallback? onDone;
  final VoidCallback? onCancel;
  final void Function(Future<String?> Function() defaultCallbace,
      ValueSetter<String?> callback)? onAdd;
  final void Function(
      String oldValue,
      Future<String?> Function(String oldValue) defaultCallbace,
      ValueSetter<String?> callback)? onEdit;
  final void Function(
      String oldValue,
      Future<String?> Function(String oldValue) defaultCallbace,
      ValueSetter<String?> callback)? onDelete;

  // final List<Widget>? actions;

  final String title;
  const MultipleLineTextEditor(
      {this.onCancel,
      // this.actions,
      this.initialDatas,
      this.onDone,
      this.onEdit,
      this.onDelete,
      this.leadingIcon,
      this.onAdd,
      required this.title,
      super.key});

  @override
  State<MultipleLineTextEditor> createState() => _MultipleLineTextEditorState();
}

class _MultipleLineTextEditorState extends State<MultipleLineTextEditor> {
  late final List<String> values = widget.initialDatas ?? [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            title: widget.title,
            onDone: () {
              Navigator.of(context).pop(values);
            },
            onCancel: () {
              Navigator.of(context).pop();
            }),
        body: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: values.length + 1,
            itemBuilder: (context, index) {
              if (index == values.length) {
                // if (widget.actions != null) {
                //   return Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: widget.actions!);
                // }
                return TextButton(
                    onPressed: () async {
                      Future<String?> callback() async {
                        return await Navigator.of(context)
                            .push<String>(MaterialPageRoute(builder: (_) {
                          return SingleLineTextContentEditor(
                              title: widget.title);
                        }));
                      }

                      if (widget.onAdd != null) {
                        widget.onAdd!(callback, (value) {
                          if (value != null) {
                            values.add(value);
                            setState(() {});
                          }
                        });
                      } else {
                        final newValue = await callback();
                        if (newValue != null) {
                          values.add(newValue);
                        }
                      }
                    },
                    child:
                        Text(LocaleInitial.genericButtonLabel.labelAt("add")));
              } else {
                final String value = values.elementAt(index);
                final uuid = const Uuid().v4();
                return Dismissible(
                    key: Key(uuid),
                    onDismissed: (diretion) {
                      values.remove(value);
                    },
                    child: Row(children: [
                      Row(children: [
                        SizedBox(
                            width: 100, child: Text(index == 0 ? "羽毛球品牌" : "")),
                        Text(value)
                      ])
                    ]));
              }
            }));
  }
}
