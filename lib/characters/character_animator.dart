import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';

/// Class representing the generic animations for players and creatures alike.
class CharacterAnimator extends SpriteAnimationGroupComponent<MovementState> {

  /// The time between frames in the animation.
  static const double _stepTime = 0.25;

  CharacterAnimator(SpriteSheet sheet) {
    animations = {
      MovementState.idleTop: sheet.createAnimation(row: 3, stepTime: _stepTime, to: 1),
      MovementState.idleBottom: sheet.createAnimation(row: 0, stepTime: _stepTime, to: 1),
      MovementState.idleLeft: sheet.createAnimation(row: 1, stepTime: _stepTime, to: 1),
      MovementState.idleRight: sheet.createAnimation(row: 2, stepTime: _stepTime, to: 1),

      MovementState.walkingTop: sheet.createAnimation(row: 3, stepTime: _stepTime),
      MovementState.walkingBottom: sheet.createAnimation(row: 0, stepTime: _stepTime),
      MovementState.walkingLeft: sheet.createAnimation(row: 1, stepTime: _stepTime),
      MovementState.walkingRight: sheet.createAnimation(row: 2, stepTime: _stepTime)
    };
  }
}