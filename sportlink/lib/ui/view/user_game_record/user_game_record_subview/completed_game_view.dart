import 'package:flutter/material.dart';

class CompletedGameView extends StatelessWidget {
  const CompletedGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(12), children: [
      Text("Past Game"),
      Text("GAME 1"),
      Text("GAME 1"),
      Text("GAME 1"),
      Text("GAME 1"),
    ]);
  }
}
