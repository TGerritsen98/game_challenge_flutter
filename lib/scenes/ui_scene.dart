import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/scenes/world_scene.dart';
import 'package:game_challenge_flutter/systems/health_system.dart';
import 'package:game_challenge_flutter/ui/countdown_timer.dart';

/// Class representing the UI in the game, which is loaded in next to the
/// [WorldScene].
class UIScene extends Scene with HasGameReference<FlutterGame> {

  /// Method to load in the [HealthSystem] alongside a [CountdownTimer] to
  /// determine that the game has won.
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