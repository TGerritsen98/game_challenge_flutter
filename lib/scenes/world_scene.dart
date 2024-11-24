import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/characters/creatures/creature_data.dart';
import 'package:game_challenge_flutter/characters/player/player.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/systems/creature_spawner.dart';

class WorldScene extends Scene {

  @override
  FutureOr<void> onLoad() async {
    addGameObject(Player(Vector2.zero()));
    var spawner = addGameObject(CreatureSpawner(20, 2));

    spawner.addTemplate(CreatureData('Starly.png', 'Starly.mp3', 30));
    spawner.addTemplate(CreatureData('Talonflame.png', 'Talonflame.mp3', 20));
    spawner.addTemplate(CreatureData('Articuno.png', 'Articuno.mp3', 40));
    spawner.addTemplate(CreatureData('Zapdos.png', 'Zapdos.mp3', 40));
    spawner.addTemplate(CreatureData('Moltres.png', 'Moltres.mp3', 40));
  }
}