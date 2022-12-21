import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sportlink/static/content/local.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';
import 'package:uuid/uuid.dart';

class InlineTextSpanEditor extends StatefulWidget {
  final String title;
  final List<String>? initialValues;
  final ValueSetter<List<String>>? onDone;
  final VoidCallback? onCancel;
  const InlineTextSpanEditor(
      {required this.title,
      this.initialValues,
      this.onCancel,
      this.onDone,
      super.key});

  @override
  State<InlineTextSpanEditor> createState() => _InlineTextSpanEditorState();
}

class _InlineTextSpanEditorState extends State<InlineTextSpanEditor> {
  late final List<String> values = widget.initialValues ?? [];

  final KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  void onCancel() {
    final bool isKeyboardVisible = keyboardVisibilityController.isVisible;
    if (isKeyboardVisible) {
      FocusScope.of(context).requestFocus(FocusNode());
    } else {
      Navigator.of(context).pop(values);
      widget.onCancel?.call();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController scontroller = ScrollController();

  // List<ui.LineMetrics> lines = textPainter.computeLineMetrics();

  bool autoFocusLast = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
        controller: keyboardVisibilityController,
        child: Scaffold(
            appBar: AppbarForEditor(
                title: widget.title,
                onDone: () {
                  Navigator.of(context).pop<List<String>>(values);
                  widget.onDone?.call(values);
                },
                onCancel: onCancel),
            body: SafeArea(
                child: ReorderableListView.builder(
                    physics: const ClampingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    buildDefaultDragHandles: false,
                    scrollController: scontroller,
                    itemBuilder: (context, index) {
                      final key = Key(const Uuid().v4());

                      if (index == values.length) {
                        return Container(
                          key: key,
                          margin: const EdgeInsets.only(
                              bottom: 24, top: 12, right: 12, left: 12),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  autoFocusLast = true;
                                  values.add("");
                                });
                              },
                              child: Text(LocaleInitial.genericButtonLabel
                                  .labelAt("add"))),
                        );
                      } else {
                        final FocusNode node = FocusNode();
                        // debugPrint(
                        //     "auto focus last: $autoFocusLast index :${index == (values.length - 1)}");
                        if (autoFocusLast && index == (values.length - 1)) {
                          Future.delayed(const Duration(milliseconds: 250), () {
                            autoFocusLast = false;
                          });
                        }
                        return Dismissible(
                            onDismissed: (direction) {
                              debugPrint("dismiss");
                              values.removeAt(index);
                              setState(() {});
                            },
                            key: key,
                            child: Padding(
                                key: key,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: TextField(
                                              autofocus: autoFocusLast &&
                                                  index == (values.length - 1),
                                              focusNode: node,
                                              readOnly: false,
                                              onChanged: ((value) {
                                                values.removeAt(index);
                                                values.insert(index, value);
                                              }),
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: TextEditingController(
                                                  text:
                                                      values.elementAt(index)),
                                              decoration: InputDecoration(
                                                  border:
                                                      const UnderlineInputBorder(),
                                                  prefixText: "${index + 1}:  ",
                                                  prefixStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                              maxLines: null,
                                              minLines: null
                                              // autofillHints: List.generate(99, (index) => index.toString()),
                                              // controller: controller
                                              )),
                                      const SizedBox(width: 24),
                                      ReorderableDragStartListener(
                                          index: index,
                                          child: const Card(
                                              color: Colors.transparent,
                                              elevation: 2,
                                              child: SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Icon(Icons.reorder,
                                                      color: Colors.white60))))
                                    ])));
                      }
                    },
                    itemCount: values.length + 1,
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final v = values.removeAt(oldIndex);
                        values.insert(newIndex, v);
                      });
                    }))));
  }
}
