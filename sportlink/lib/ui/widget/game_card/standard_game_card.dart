import 'package:flutter/material.dart';
import 'package:sportlink/model/models/game.dart';

class StandardGameCard extends StatelessWidget {
  final Game game;
  const StandardGameCard({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(12),
      child: Text(game.localeContent.title),
    ));
  }
}
