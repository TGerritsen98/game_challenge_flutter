import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/events/win_event.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/systems/health_system.dart';
import 'package:game_challenge_flutter/ui/countdown_timer.dart';

class UIScene extends Scene {

  @override
  FutureOr<void> onLoad() {
    addGameObject(HealthSystem(3));
    add(CountdownTimer(
        60,
        onComplete: win,
        position: Vector2(300, -300),
        anchor: Anchor.center)
    );
  }

  void win() {
    WinEvent.invoke();
  }
}