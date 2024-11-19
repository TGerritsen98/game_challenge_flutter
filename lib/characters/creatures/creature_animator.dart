import 'package:flame/components.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';

class CreatureAnimator extends Component {

  final CharacterAnimator animator;

  CreatureAnimator(this.animator) {
    animator.current = MovementState.walkingBottom;
  }
}