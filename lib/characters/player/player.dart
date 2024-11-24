import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/rendering.dart';
import 'package:flame/sprite.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/player/player_animator.dart';
import 'package:game_challenge_flutter/characters/player/player_movement.dart';
import 'package:game_challenge_flutter/game_object.dart';
import 'package:game_challenge_flutter/globals.dart';

class Player extends GameObject {

  static const String imageFile = 'Dawn.png';

  Player(Vector2 position) {
    priority = 2;
    this.position = position;
    anchor = Anchor.center;
    tag = "Player";
  }

  @override
  FutureOr<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(imageFile),
      srcSize: Globals.spriteSize,
    );

    decorator.addLast(Shadow3DDecorator(
      base: position - Vector2(0, -32)
    ));

    final animator = append(CharacterAnimator(spriteSheet));
    add(PlayerAnimator(animator));
    add(PlayerMovement(this));
  }
}