import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:game_challenge_flutter/scenes/world_scene.dart';

class FlutterGame extends FlameGame with HasKeyboardHandlerComponents {

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    world.add(WorldScene());
  }
}