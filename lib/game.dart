import 'dart:async';
import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_challenge_flutter/scenes/ui_scene.dart';
import 'package:game_challenge_flutter/scenes/world_scene.dart';

class FlutterGame extends FlameGame with HasKeyboardHandlerComponents, TapCallbacks {

  bool soundEnabled = false;

  @override
  FutureOr<void> onLoad() {
    FlameAudio.bgm.initialize();

    world.add(WorldScene());
    world.add(UIScene());
  }

  @override
  Color backgroundColor() => const Color(0xFFFF9000);

  @override
  void onTapDown(TapDownEvent event) {
    if (soundEnabled) return;

    soundEnabled = true;
    FlameAudio.bgm.play('Battle.mp3');
  }
}