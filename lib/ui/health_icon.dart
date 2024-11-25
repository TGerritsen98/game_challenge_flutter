import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';

class HealthIcon extends SpriteComponent {

  /// The image of this icon.
  final String _image;

  HealthIcon(this._image, {super.position, super.anchor, super.scale, super.priority});

  /// Method called on initialization.
  ///
  /// This method will load in the sprite to show as the icon.
  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(await Flame.images.load(_image));
  }

  /// Method to damage the health icon.
  ///
  /// This method will scale the health icon to 0 before removing it completely
  /// from the game.
  void damage() async {
    add(ScaleEffect.to(
      Vector2.all(0),
      EffectController(duration: 0.5),
    ));

    await Future.delayed(const Duration(milliseconds: 500));

    removeFromParent();
  }
}