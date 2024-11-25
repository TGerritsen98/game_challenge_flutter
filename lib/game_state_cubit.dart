import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_status.dart';

class GameState {

  final GameStatus status;

  const GameState(this.status);
}

class GameStateCubit extends Cubit<GameState> {

  GameStateCubit() : super(const GameState(GameStatus.playing));

  void win() => emit(const GameState(GameStatus.won));
  void gameOver() => emit(const GameState(GameStatus.gameOver));
  void restart() => emit(const GameState(GameStatus.playing));
}
