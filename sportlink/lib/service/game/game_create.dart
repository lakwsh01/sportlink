import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportlink/demo/game.dart';
import 'package:sportlink/model/models/game.dart';

Future<Game> createGame(Map template) async {
  final res = await FirebaseFirestore.instance
      .collection("game")
      .add(gameDemo)
      .catchError((e) {
    debugPrint(e);
  });
  return Game(game: gameDemo, id: res.id);
}
