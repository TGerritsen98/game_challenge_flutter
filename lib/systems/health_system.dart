import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/events/game_over_event.dart';
import 'package:game_challenge_flutter/events/life_event.dart';
import 'package:game_challenge_flutter/game_object.dart';
import 'package:game_challenge_flutter/ui/health_icon.dart';

class HealthSystem extends GameObject {

  static const double _cooldownSeconds = 5;
  late final Timer _cooldownTimer;
  final List<HealthIcon> sprites = List.empty(growable: true);
  bool _damageable = true;

  HealthSystem(int health) {
    for (var i = 0; i < health; i++) {
      final icon = append(HealthIcon(Vector2(-50 + 50.0 * i, -300)));
      sprites.add(icon);
    }

    _cooldownTimer = Timer(_cooldownSeconds, repeat: false, onTick: () {
      _damageable = true;
      }
    );
  }

  @override
  FutureOr<void> onLoad() {
    LifeEvent.subscribe(_damage);
  }

  @override
  void update(double dt) {
    _cooldownTimer.update(dt);
  }

  void _damage() {
    if (!_damageable || sprites.isEmpty) return;

    var icon = sprites.last;
    icon.damage();
    sprites.removeLast();

    if (sprites.isEmpty) {
      GameOverEvent.invoke();
    } else {
      _damageable = false;
      _cooldownTimer.start();
    }
  }

  @override
  void onRemove() {
    LifeEvent.unsubscribe(_damage);
  }
}