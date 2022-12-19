import 'package:flutter/material.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/model/models/application.dart';
import 'package:sportlink/ui/view/game_create/game_editor_view.dart';
import 'package:sportlink/ui/view/user_game_record/user_game_record_subview/coming_game_view.dart';
import 'package:sportlink/ui/view/user_game_record/user_game_record_subview/completed_game_view.dart';

class UserGameRecordView extends StatelessWidget {
  final List<Game> comingGames;
  final List<Game> pastGames;
  final List<Game> myGames;
  final List<Application> pendingApplication;
  final List<Application> rejectedApplication;

  const UserGameRecordView(
      {super.key,
      required this.comingGames,
      required this.myGames,
      required this.pastGames,
      required this.pendingApplication,
      required this.rejectedApplication});

  List<Tab> get tabs => [Tab(text: "將舉行"), Tab(text: "處理中"), Tab(text: "已結束")];
  List<Widget> get views =>
      [ComingGameView(), ComingGameView(), CompletedGameView()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            body: Column(
          children: [
            Material(
                color: Colors.transparent,
                child: SafeArea(
                    child: TabBar(labelColor: Colors.black, tabs: tabs))),
            Expanded(child: TabBarView(children: views))
          ],
        )));
  }
}

class UserJoinedGameRecordCard extends StatelessWidget {
  final Game game;

  const UserJoinedGameRecordCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class UserMyGameRecordCard extends StatelessWidget {
  final Game game;
  const UserMyGameRecordCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class UserApplicationRecordCard extends StatelessWidget {
  final Game game;
  const UserApplicationRecordCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
