import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';

class HealthIcon extends SpriteComponent {

  HealthIcon(Vector2 position) {
    super.position = position;
    anchor = Anchor.center;
    scale = Vector2.all(5);
    priority = 10;
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(await Flame.images.load('Heart.png'));
  }

  void damage() async {
    add(ScaleEffect.to(
      Vector2.all(0),
      EffectController(duration: 0.5),
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    removeFromParent();
  }
}