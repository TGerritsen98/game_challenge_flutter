import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:game_challenge_flutter/events/restart_game_event.dart';

class RestartButton extends SpriteButtonComponent {

  @override
  FutureOr<void> onLoad() async {
    priority = 10;
    scale = Vector2.all(0.5);
    button = Sprite(await Flame.images.load('Restart.png'));
    onPressed = _pressed;
    anchor = Anchor.center;
  }

  void _pressed() {
    RestartGameEvent.invoke();
  }
}