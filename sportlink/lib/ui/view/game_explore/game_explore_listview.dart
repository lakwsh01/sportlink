import 'package:flutter/material.dart';
import 'package:sportlink/demo/game.dart';
import 'package:sportlink/model/model.dart';
import 'package:sportlink/ui/widget/game_card/standard_game_card.dart';

class GameExploreListView extends StatelessWidget {
  const GameExploreListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(itemBuilder: (context, int index) {
          return StandardGameCard(game: Game(game: gameDemo, id: "id"));
        }));
  }
}
