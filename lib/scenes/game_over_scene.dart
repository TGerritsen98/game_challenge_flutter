import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';

/// Class representing the 'Game Over' scene in the game.
///
/// This scene is triggered when the game transitioned to the 'Game Over'
/// state.
class GameOverScene extends Scene with HasGameReference<FlutterGame> {

  /// Method to load in a restart button and a text saying it is game over.
  @override
  FutureOr<void> onLoad() async {
    add(SpriteButtonComponent(
        priority: 10,
        anchor: Anchor.center,
        scale: Vector2.all(0.5),
        button: Sprite(await Flame.images.load('Restart.png')),
      onPressed: game.state.restart
    ));

    add(TextComponent(
        text: 'You lose!',
        priority: 20,
        position: Vector2(0, 200),
        anchor: Anchor.center)
    );
  }
}