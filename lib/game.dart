import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_challenge_flutter/events/game_over_event.dart';
import 'package:game_challenge_flutter/events/restart_game_event.dart';
import 'package:game_challenge_flutter/events/win_event.dart';
import 'package:game_challenge_flutter/game_status.dart';
import 'package:game_challenge_flutter/scenes/game_over_scene.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/scenes/ui_scene.dart';
import 'package:game_challenge_flutter/scenes/win_scene.dart';
import 'package:game_challenge_flutter/scenes/world_scene.dart';

class FlutterGame extends FlameGame with HasKeyboardHandlerComponents, TapCallbacks, HasTimeScale {

  final List<Scene> _scenes = List.empty(growable: true);
  bool soundEnabled = false;
  GameStatus _status = GameStatus.playing;

  @override
  FutureOr<void> onLoad() {
    FlameAudio.bgm.initialize();

    WinEvent.subscribe(_win);
    GameOverEvent.subscribe(_gameOver);
    RestartGameEvent.subscribe(_restart);

    _loadGame();
  }

  void _loadGame() {
    timeScale = 1.0;

    _addScene(WorldScene());
    _addScene(UIScene());
  }

  void _unloadGame() {
    for (var scene in _scenes) {
      world.remove(scene);
    }

    _scenes.clear();
  }

  void _win() {
    if (_status == GameStatus.gameOver) return;

    _status = GameStatus.won;
    timeScale = 0.0;

    _addScene(WinScene());
  }

  void _gameOver() {
    if (_status == GameStatus.won) return;

    _status = GameStatus.gameOver;
    timeScale = 0.0;

    _addScene(GameOverScene());
  }

  void _restart() {
    _unloadGame();
    _loadGame();

    _status = GameStatus.playing;
    timeScale = 1.0;
  }

  void _addScene(Scene scene) {
    world.add(scene);
    _scenes.add(scene);
  }

  @override
  Color backgroundColor() => const Color(0xFFFF9000);

  @override
  void onTapDown(TapDownEvent event) {
    if (soundEnabled) return;

    soundEnabled = true;
    FlameAudio.bgm.play('Battle.mp3');
  }

  @override
  void onRemove() {
    WinEvent.unsubscribe(_win);
    GameOverEvent.unsubscribe(_gameOver);
    RestartGameEvent.unsubscribe(_restart);
  }
}