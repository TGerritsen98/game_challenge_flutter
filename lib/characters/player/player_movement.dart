import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_challenge_flutter/game_object.dart';

class PlayerMovement extends Component with KeyboardHandler {

  static const double speed = 60;
  final GameObject gameObject;
  Vector2 velocity = Vector2.zero();

  PlayerMovement(this.gameObject);

  @override
  void update(double dt) {
    gameObject.position += velocity * speed * dt;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity.setZero();

    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.keyW)) velocity.y = -1;
      if (keysPressed.contains(LogicalKeyboardKey.keyS)) velocity.y = 1;
      if (keysPressed.contains(LogicalKeyboardKey.keyA)) velocity.x = -1;
      if (keysPressed.contains(LogicalKeyboardKey.keyD)) velocity.x = 1;

      velocity.normalize();
    }

    return true;
  }
}
