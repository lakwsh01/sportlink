import 'package:flutter/material.dart';

class ComingGameView extends StatelessWidget {
  const ComingGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(12), children: [
      Text("My Game"),
      Text("GAME 1"),
      Text("Game You Joined"),
      Text("GAME 1")
    ]);
  }
}
