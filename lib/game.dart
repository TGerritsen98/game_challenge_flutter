import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:game_challenge_flutter/game_state_cubit.dart';
import 'package:game_challenge_flutter/game_status.dart';
import 'package:game_challenge_flutter/scenes/game_over_scene.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/scenes/ui_scene.dart';
import 'package:game_challenge_flutter/scenes/win_scene.dart';
import 'package:game_challenge_flutter/scenes/world_scene.dart';

/// Class representing the whole game. This class is responsible for handling
/// the game state and transitions between.
class FlutterGame extends FlameGame with HasKeyboardHandlerComponents, TapCallbacks, HasTimeScale {

  /// List of currently active scenes in the game.
  final List<Scene> _scenes = List.empty(growable: true);

  /// True if the player has enabled audio, otherwise false.
  bool soundEnabled = false;

  /// The Cubit bloc controlling the state of the game. Use this Cubit to change
  /// the state of the game.
  late final GameStateCubit state;

  @override
  FutureOr<void> onLoad() {
    // Initialize background audio
    FlameAudio.bgm.initialize();

    // Setup Cubit bloc for game state management
    state = GameStateCubit();
    state.stream.listen(_onGameStateChange);

    add(FlameBlocProvider<GameStateCubit, GameState>(
        create: () => state
    ));

    // Initial game loading
    _loadGame();
  }

  /// Method to load in the [WorldScene] and [UIScene].
  void _loadGame() {
    _addScene(WorldScene());
    _addScene(UIScene());
  }

  /// Method to unload all currently loaded scenes.
  void _unloadGame() {
    for (var scene in _scenes) {
      world.remove(scene);
    }

    _scenes.clear();
  }

  void _onGameStateChange(GameState state) {
    switch (state.status) {
      case GameStatus.playing: _restartGame();
      case GameStatus.won: _showWinScene();
      case GameStatus.gameOver: _showGameOverScene();
    }
  }

  /// Method to show the [WinScene]. This will also pause the game until a
  /// restart.
  void _showWinScene() {
    timeScale = 0.0;
    _addScene(WinScene());
  }

  /// Method to show the [GameOverScene]. This will also pause the game until
  /// a restart.
  void _showGameOverScene() {
    timeScale = 0.0;
    _addScene(GameOverScene());
  }

  /// Method to restart the game by unloading and reloading all relevant scenes.
  /// After everything is loaded in, the game will unpause.
  void _restartGame() {
    _unloadGame();
    _loadGame();
    timeScale = 1.0;
  }

  /// Method to add a scene to the currently loaded scenes to be managed.
  void _addScene(Scene scene) {
    world.add(scene);
    _scenes.add(scene);
  }

  /// Method to change the background color to a bright orange.
  @override
  Color backgroundColor() => const Color(0xFFFF9000);

  /// Method called when the player clicks on the screen. This act will enable
  /// the background music and all other sound effects in conform with
  /// [Chrome's autoplay policies](https://developer.chrome.com/blog/autoplay/).
  @override
  void onTapDown(TapDownEvent event) {
    if (soundEnabled) return;

    soundEnabled = true;
    FlameAudio.bgm.play('Battle.mp3');
  }

  /// Method called when the game is quit. This will stop listening to state
  /// changes.
  @override
  void onRemove() {
    state.close();
  }
}
