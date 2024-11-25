import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/ui/restart_button.dart';

class GameOverScene extends Scene {

  @override
  FutureOr<void> onLoad() {
    add(RestartButton());

    add(TextComponent(
        text: 'You lose!',
        priority: 20,
        position: Vector2(0, 200),
        anchor: Anchor.center)
    );
  }
}