import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_challenge_flutter/game_status.dart';

/// Class representing the entry point for game state transitions.
class GameStateCubit extends Cubit<GameStatus> {

  GameStateCubit() : super(GameStatus.playing);

  /// Method to transition to the 'Win' game state.
  void win() => emit(GameStatus.won);

  /// Method to transition to the 'Game Over' game state.
  void gameOver() => emit(GameStatus.gameOver);

  /// Method to transition back to the 'Playing' game state.
  void restart() => emit(GameStatus.playing);
}
