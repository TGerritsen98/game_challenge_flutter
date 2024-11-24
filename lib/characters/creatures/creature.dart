import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/particles.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:game_challenge_flutter/characters/character_animator.dart';
import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/characters/movement_state.dart';
import 'package:game_challenge_flutter/game.dart';
import 'package:game_challenge_flutter/game_object.dart';

class Creature extends GameObject with HasGameReference<FlutterGame> {

  double speed = 0;

  bool active = false;
  GameObject? target;
  CharacterAnimator? animator;

  Creature() {
    priority = 2;
    anchor = Anchor.center;
  }

  @override
  FutureOr<void> onLoad() {
    target = scene?.findWithTag("Player");
  }

  void activate(CreatureData data) async {
    if (active) return;

    // Animator
    final sheet = await data.sheet();

    animator = append(CharacterAnimator(sheet));
    animator?.current = MovementState.walkingBottom;

    // 3D shadow decorator
    decorator.addLast(Shadow3DDecorator(
        base: position - Vector2(0, -32)
    ));

    // Sound effect
    if (game.soundEnabled) data.play();

    // General data
    speed = data.speed;
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

  @override
  void update(double dt) {
    if (!active || target == null) return;

    final currentPosition = position;
    final targetPosition = target!.position;
    final direction = (targetPosition - currentPosition).normalized();
    final movement = direction * speed * dt;

    if ((currentPosition + movement).distanceTo(targetPosition) < movement.length) {
      position = targetPosition;
    } else {
      position += movement;
    }
  }
}