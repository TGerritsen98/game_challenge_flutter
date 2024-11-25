import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';
import 'package:game_challenge_flutter/events/life_event.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/game_object.dart';

/// Class representing a creature in the game which can be instantiated at a
/// later moment after being added to the game.
class Creature extends GameObject with HasGameReference<FlutterGame> {

  /// The component to target to walk to.
  PositionComponent? _target;

  /// The animator possibly in use.
  CharacterAnimator? _animator;

  /// The current movement speed of the creature.
  double _speed = 0;

  /// True if this creature has been initialized with [CreatureData], otherwise
  /// false.
  bool active = false;

  Creature() : super(
      priority: 2,
      anchor: Anchor.center
  );

  /// Method called to find a suitable target within the current scene.
  @override
  FutureOr<void> onLoad() {
    _target = scene?.findWithTag("Player");
  }

  /// Method to initialize the creature with new [CreatureData].
  void activate(CreatureData data) async {
    if (active) return;

    // Animator
    final sheet = await data.sheet();

    _animator = append(CharacterAnimator(sheet));
    _animator?.current = MovementState.walkingBottom;

    // 3D shadow decorator
    decorator.addLast(Shadow3DDecorator(
        base: position - Vector2(0, -32)
    ));

    // Sound effect
    if (game.soundEnabled) data.play();

    // General data
    _speed = data.speed;
    position = (Vector2.random() * 2 - Vector2.all(1)) * 300;
    scale = Vector2.all(0);

    // Summoning effect
    add(ScaleEffect.to(
      Vector2.all(1),
      EffectController(duration: 0.5),
    ));

    // Summon particles
    add(ParticleSystemComponent(
        particle: Particle.generate(
          count: 10,
          generator: (i) => AcceleratedParticle(
            acceleration: (Vector2.random() - Vector2.random()) * 200,
            child: CircleParticle(
              paint: Paint()..color = Colors.white,
              radius: 2
            ),
          ),
        ),
      ),
    );

    active = true;
  }

  /// Method to move the creature in the direction of the player and possibly
  /// attack.
  ///
  /// This method only works when the creature is instantiated with
  /// [CreatureData] and has a valid target.
  @override
  void update(double dt) {
    if (!active || _target == null) return;

    final currentPosition = position;
    final targetPosition = _target!.position;
    final direction = (targetPosition - currentPosition).normalized();
    final movement = direction * _speed * dt;

    if ((currentPosition + movement).distanceTo(targetPosition) < movement.length) {
      position = targetPosition;
      LifeEvent.invoke();
    } else {
      position += movement;
    }
  }
}