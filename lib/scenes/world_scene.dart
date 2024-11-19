import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_challenge_flutter/characters/creatures/creature.dart';
import 'package:game_challenge_flutter/characters/player/player.dart';

class WorldScene extends Component {

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(Player(Vector2.zero(), 100));
    add(Creature(Vector2(0, 100), 100, 'Starly.png'));
  }
}