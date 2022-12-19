import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/demo/field_rule.dart';
import 'package:sportlink/static/style/standard_button_theme.dart';
import 'package:sportlink/static/style/standard_layout.dart';
import 'package:sportlink/ui/view/game_apply/application_setting.dart';
import 'package:sportlink/ui/view/game_apply/field_rule_view.dart';

class GameApplicationSheet extends StatefulWidget {
  final PageController? pageController;
  final VoidCallback? onApplyCancel;
  const GameApplicationSheet(
      {this.onApplyCancel, this.pageController, super.key});

  @override
  State<GameApplicationSheet> createState() => _GameApplicationSheetState();
}

class _GameApplicationSheetState extends State<GameApplicationSheet> {
  late final PageController pageController =
      widget.pageController ?? PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: standardBottomSheetPadding,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                      style: StandardButtonStyleType.standard.style,
                      onPressed: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear);
                        }
                      },
                      child: Text("game-apply.button-label-next".tr())),
                  TextButton(
                      style: StandardButtonStyleType.cancel.style,
                      onPressed: () {
                        final pg = pageController.page;
                        if (pg == 1) {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            setState(() {});
                          });
                        } else {
                          setState(() {});
                        }
                        widget.onApplyCancel?.call();
                      },
                      child: Text("game-apply.button-label-cancel".tr()))
                ])),
        backgroundColor: Colors.transparent,
        body: PageView(
            onPageChanged: (page) {
              // debugPrint(
              //     "Game Detail View ::: set stage ::: page: ${pageController.page} ::: showApply : $showApplyButton");
              // setState(() {});
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Padding(
                  padding: standardBottomSheetPadding,
                  // padding: EdgeInsets.zero,
                  child: FieldRuleView(rules: fieldRulesDemo)),
              const Padding(
                  padding: standardBottomSheetPadding,
                  // padding: EdgeInsets.zero,
                  child: ApplicationSettingView())
            ]));
  }
}
