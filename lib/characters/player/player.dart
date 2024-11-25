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

/// Class representing the player within the game.
class Player extends GameObject {

  /// The image of the player.
  static const String _imageFile = 'Player.png';

  Player({super.position}) : super(
      tag: "Player",
      priority: 2,
      anchor: Anchor.center
  );

  /// Method to load in the sprite sheet, create a shadow under the player, and
  /// start the [PlayerAnimator] and [PlayerMovement]
  @override
  FutureOr<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load(_imageFile),
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