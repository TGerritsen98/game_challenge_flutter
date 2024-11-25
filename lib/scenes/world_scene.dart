import 'dart:async';

import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/characters/player/player.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/systems/creature_spawner.dart';

/// Class representing the overworld scene in the game. This scene included the
/// player alongside the spawned creatures.
class WorldScene extends Scene {

  /// Method to create the [Player] and a [CreatureSpawner] to automatically
  /// spawn in creatures from a pool.
  @override
  FutureOr<void> onLoad() async {
    addGameObject(Player());
    addGameObject(CreatureSpawner(20, 2)
        .addTemplate(CreatureData('Starly.png', 'Starly.mp3', 30))
        .addTemplate(CreatureData('Talonflame.png', 'Talonflame.mp3', 20))
        .addTemplate(CreatureData('Articuno.png', 'Articuno.mp3', 40))
        .addTemplate(CreatureData('Zapdos.png', 'Zapdos.mp3', 40))
        .addTemplate(CreatureData('Moltres.png', 'Moltres.mp3', 40))
    );
  }
}