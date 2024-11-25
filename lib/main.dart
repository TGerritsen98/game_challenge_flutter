import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_challenge_flutter/game.dart';

void main() {
  final game = FlutterGame();

  runApp(GameWidget(game: game));
}
