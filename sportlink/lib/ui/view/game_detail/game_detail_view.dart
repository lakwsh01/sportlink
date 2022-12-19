import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/model/models/base/profile_snap.dart';
import 'package:sportlink/service/game/game_apply.dart';
import 'package:sportlink/service/game/game_create.dart';
import 'package:sportlink/static/style/standard_button_theme.dart';
import 'package:sportlink/static/style/standard_layout.dart';
import 'package:sportlink/ui/view/game_apply/application_setting.dart';
import 'package:sportlink/ui/view/game_apply/field_rule_view.dart';
import 'package:sportlink/ui/view/game_apply/game_apply_complete.dart';
import 'package:sportlink/ui/view/game_detail/game_detail_view_bottom.dart';
import 'package:sportlink/ui/view/game_detail/game_detail_view_front.dart';

class GameDetailView extends StatefulWidget {
  const GameDetailView(
      {required this.profileSnap, required this.game, super.key});
  final Game game;
  final ProfileSnap profileSnap;

  @override
  State<GameDetailView> createState() => _GameDetailViewState();
}

class _GameDetailViewState extends State<GameDetailView> {
  late final Game game = widget.game;
  late final ProfileSnap profileSnap = widget.profileSnap;
  late final PageController _pageController = PageController(initialPage: 0);
  int bottomSheetLevel = 0;
  bool showApplyButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: Stack(fit: StackFit.expand, children: [
          GameDetailViewFront(game: game),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              bottom: bottomSheetLevel == 1
                  ? 0
                  : -(MediaQuery.of(context).size.height - 80),
              left: 0,
              child: BottomAppBar(
                  elevation: 12,
                  color: Colors.white,
                  notchMargin: 8,
                  shape: const CircularNotchedRectangle(),
                  child: SafeArea(
                      child: GameApplicationSheet(
                    pageController: _pageController,
                    onApplyCancel: () {
                      bottomSheetLevel = 0;
                      setState(() {});

                      Future.delayed(const Duration(milliseconds: 250), () {
                        showApplyButton = true;
                        setState(() {});
                      });
                    },
                  ))))
        ])
        // )
        ,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomSheet: SizedBox(height: 75),
        floatingActionButton: showApplyButton
            ? FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Icon(Icons.add),
                onPressed: () {
                  createGame({}).then((value) => applyGame(value));
                  if (bottomSheetLevel == 0) {
                    bottomSheetLevel = 1;
                    showApplyButton = false;
                    setState(() {});
                  }
                })
            : null);
  }
}
