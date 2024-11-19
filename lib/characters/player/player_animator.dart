import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';

class PlayerAnimator extends Component with KeyboardHandler {

  static const double stepTime = 0.25;
  final CharacterAnimator animator;

  PlayerAnimator(this.animator) {
    animator.current = MovementState.idleBottom;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.keyW)) animator.current = MovementState.walkingTop;
      if (keysPressed.contains(LogicalKeyboardKey.keyA)) animator.current = MovementState.walkingLeft;
      if (keysPressed.contains(LogicalKeyboardKey.keyS)) animator.current = MovementState.walkingBottom;
      if (keysPressed.contains(LogicalKeyboardKey.keyD)) animator.current = MovementState.walkingRight;
    }

    if (event is KeyUpEvent) {
      if (animator.current == MovementState.walkingTop) animator.current = MovementState.idleTop;
      if (animator.current == MovementState.walkingLeft) animator.current = MovementState.idleLeft;
      if (animator.current == MovementState.walkingBottom) animator.current = MovementState.idleBottom;
      if (animator.current == MovementState.walkingRight) animator.current = MovementState.idleRight;
    }

    return true;
  }
}