import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/characters/creatures/creature.dart';
import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/game_object.dart';

/// Class representing a spawner that automatically spawns in new [Creature]s
/// from an internal pool.
class CreatureSpawner extends GameObject {

  static final _random = Random();

  /// A list with possible creatures to spawn when needed.
  final List<CreatureData> _templates = List.empty(growable: true);

  /// A list of known creatures within the pool.
  final List<Creature> _pool = List.empty(growable: true);

  /// The amount of creatures to spawn in the pool.
  final int _amount;
  final double _period;

  CreatureSpawner(this._amount, this._period);

  /// Method called to start the spawner. This method will pre-spawn all the
  /// creatures, and start a clock to, one by one, initialize each creature.
  @override
  FutureOr<void> onLoad() {
    add(TimerComponent(
        period: _period,
        repeat: true,
        onTick: () { _spawn(); }
    ));

    for (var i = 0; i < _amount; i++) {
      final creature = addGameObject(Creature());
      _pool.add(creature);
    }
  }

  /// Method to add a new template of a [Creature] to the spawner to randomly
  /// pick from.
  CreatureSpawner addTemplate(CreatureData data) {
    _templates.add(data);

    return this;
  }

  /// Method called to initialize a [Creature] with new [CreatureData]. When
  /// there are no more creatures to initialize, this method will stop.
  void _spawn() {
    final sheet = _templates[_random.nextInt(_templates.length)];
    final creature = _pool.firstWhere((c) => !c.active, orElse: () {
      final c = Creature();
      c.active = true;
      return c;
    });

    if (creature.active) return;

    creature.activate(sheet);
  }
}