import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/player/player_animator.dart';
import 'package:game_challenge_flutter/characters/player/player_movement.dart';
import 'package:game_challenge_flutter/game_object.dart';

class Player extends GameObject {

  static const String imageFile = 'Dawn.png';
  static final Vector2 spriteSize = Vector2.all(32);

  Player(Vector2 position, double scale) {
    this.position = position;
    size = Vector2.all(scale);
    anchor = Anchor.center;
  }

  @override
  FutureOr<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(imageFile),
      srcSize: spriteSize,
    );

    final animator = append(CharacterAnimator(spriteSheet));
    add(PlayerAnimator(animator));
    add(PlayerMovement(this));
  }
}