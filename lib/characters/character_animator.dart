import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';

class CharacterAnimator extends SpriteAnimationGroupComponent<MovementState> {

  static const double stepTime = 0.25;

  CharacterAnimator(SpriteSheet sheet) {
    animations = {
      MovementState.idleTop: sheet.createAnimation(row: 3, stepTime: stepTime, to: 1),
      MovementState.idleBottom: sheet.createAnimation(row: 0, stepTime: stepTime, to: 1),
      MovementState.idleLeft: sheet.createAnimation(row: 1, stepTime: stepTime, to: 1),
      MovementState.idleRight: sheet.createAnimation(row: 2, stepTime: stepTime, to: 1),

      MovementState.walkingTop: sheet.createAnimation(row: 3, stepTime: stepTime),
      MovementState.walkingBottom: sheet.createAnimation(row: 0, stepTime: stepTime),
      MovementState.walkingLeft: sheet.createAnimation(row: 1, stepTime: stepTime),
      MovementState.walkingRight: sheet.createAnimation(row: 2, stepTime: stepTime)
    };
  }
}