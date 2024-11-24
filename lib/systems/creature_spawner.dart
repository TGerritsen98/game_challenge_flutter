import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/characters/creatures/creature.dart';
import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/game_object.dart';

class CreatureSpawner extends GameObject {

  List<CreatureData> templates = List.empty(growable: true);
  List<Creature> creatures = List.empty(growable: true);
  int pool;
  double period;

  CreatureSpawner(this.pool, this.period);

  @override
  FutureOr<void> onLoad() {
    add(TimerComponent(
        period: period,
        repeat: true,
        onTick: () { _spawn(); }
    ));

    for (var i = 0; i < pool; i++) {
      final creature = addGameObject(Creature());
      creatures.add(creature);
    }
  }

  void addTemplate(CreatureData data) {
    templates.add(data);
  }

  void _spawn() {
    final random = Random();
    final sheet = templates[random.nextInt(templates.length)];
    final creature = creatures.firstWhere((c) => !c.active, orElse: () {
      final c = Creature();
      c.active = true;
      return c;
    });

    if (creature.active) return;

    creature.activate(sheet);
  }
}