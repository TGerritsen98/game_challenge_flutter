import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/events/life_event.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/game_object.dart';
import 'package:game_challenge_flutter/ui/health_icon.dart';

/// Class representing the health system.
///
/// This class handles the updating of the hearts in the game and updating the
/// game state when necessary.
class HealthSystem extends GameObject with HasGameReference<FlutterGame> {

  /// The amount of seconds to wait between damages to the health.
  static const double _cooldownSeconds = 5;

  /// A list of the hearts in the game.
  final List<HealthIcon> sprites = List.empty(growable: true);

  /// The timer to update the cooldown.
  late final Timer _cooldownTimer;

  /// True if the health can be damaged, otherwise false.
  bool _damageable = true;

  HealthSystem(int health) {
    for (var i = 0; i < health; i++) {
      final icon = append(HealthIcon(
          'Heart.png',
          position: Vector2(-50 + 50.0 * i, -300),
          anchor: Anchor.center,
          scale: Vector2.all(5),
          priority: 10
      ));

      sprites.add(icon);
    }

    _cooldownTimer = Timer(
        _cooldownSeconds,
        repeat: false,
        onTick: _makeDamageable
    );
  }

  /// Method called when initializing the health system.
  ///
  /// This method will subscribe to the [LifeEvent].
  @override
  FutureOr<void> onLoad() {
    LifeEvent.subscribe(_damage);
  }

  /// Method to update the countdown timer when active.
  @override
  void update(double dt) {
    _cooldownTimer.update(dt);
  }

  /// Method called to damage the health. This method only works when it can be
  /// damaged and has any health left.
  ///
  /// If there is some health left, it will decrease the amount of hearts.
  /// Otherwise, it will change the game to the 'Game Over' state.
  void _damage() {
    if (!_damageable || sprites.isEmpty) return;

    var icon = sprites.last;
    icon.damage();
    sprites.removeLast();

    if (sprites.isEmpty) {
      game.state.gameOver();
    } else {
      _damageable = false;
      _cooldownTimer.start();
    }
  }

  /// Method to make it possible to damage the health.
  void _makeDamageable() {
    _damageable = true;
  }

  /// Method called when removing the health system from the game.
  ///
  /// This method will remove the subscription to the [LifeEvent].
  @override
  void onRemove() {
    LifeEvent.unsubscribe(_damage);
  }
}