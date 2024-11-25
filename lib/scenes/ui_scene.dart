import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/systems/health_system.dart';
import 'package:game_challenge_flutter/ui/countdown_timer.dart';

class UIScene extends Scene with HasGameReference<FlutterGame> {

  @override
  FutureOr<void> onLoad() {
    addGameObject(HealthSystem(3));
    add(CountdownTimer(
        60,
        onComplete: game.state.win,
        position: Vector2(300, -300),
        anchor: Anchor.center)
    );
  }
}