import 'package:flutter/material.dart';
import 'package:sportlink/ui/widget/appbar/appbar_with_trilling.dart';

class TreeSelector extends StatefulWidget {
  final Map<String, String> initOptions;
  final VoidCallback? onCancel;
  final List<String> levels;
  final Widget? bottom;
  final void Function(
      String nextLevel,
      String currentLevel,
      void Function(Map<String, String> newOptions, bool endTree)
          updateCallback) onNextLevelSetter;
  final ValueSetter<String>? onConfirm;
  final String title;

  const TreeSelector(
      {this.onCancel,
      this.bottom,
      required this.levels,
      required this.onNextLevelSetter,
      this.onConfirm,
      required this.initOptions,
      required this.title,
      super.key});

  @override
  State<TreeSelector> createState() => _TreeSelectorState();
}

class _TreeSelectorState extends State<TreeSelector> {
  late Map<String, String> options = widget.initOptions;
  bool isLastOptions = false;
  int levelIndex = 0;
  String? selected;

  final GlobalKey<NavigatorState> navKey = GlobalKey();

  String get level => widget.levels.elementAt(levelIndex);

  void onTab(String index) {
    if (isLastOptions) {
      selected = index;
      setState(() {});
    } else {
      widget.onNextLevelSetter(index, level, (newOptions, endTree) {
        options = newOptions;
        isLastOptions = endTree;
        levelIndex += 1;
        debugPrint("options updated ::: level: $level");
        Future.delayed(const Duration(milliseconds: 100), () {
          navKey.currentState?.push(MaterialPageRoute(builder: (_) {
            return view;
          }));
        });
      });
    }
  }

  Widget get view {
    return Material(
        color: Colors.black,
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: options.length,
                  itemBuilder: ((context, index) {
                    final option = options.entries.elementAt(index);
                    return GestureDetector(
                        onTap: () => onTab(option.key),
                        child: Container(
                            padding: EdgeInsets.only(bottom: 12, top: 12),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white24, width: 0.5))),
                            child: Row(children: [
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(option.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ])),
                              const SizedBox(width: 48),
                              if (isLastOptions)
                                AnimatedCrossFade(
                                    crossFadeState: selected == option.key
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    firstChild: const Icon(Icons.circle,
                                        color: Colors.white10),
                                    secondChild: const Icon(Icons.check_circle),
                                    duration: const Duration(milliseconds: 500))
                            ])));
                  }))),
          if (widget.bottom != null) widget.bottom!
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarForEditor(
            showTrailing: isLastOptions,
            title: widget.title,
            onDone: () {
              if (selected != null) {
                widget.onConfirm?.call(selected!);
                Navigator.of(context).pop(selected);
              }
            },
            onCancel: widget.onCancel ??
                () {
                  Navigator.of(context).pop();
                }),
        body: Navigator(
            key: navKey,
            onGenerateRoute: (r) {
              return MaterialPageRoute(builder: (_) => view);
            }));
  }
}
