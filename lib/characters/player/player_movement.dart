import 'package:flame/components.dart';
import 'package:flutter/services.dart';

/// Class representing the implementation for the player movement.
class PlayerMovement extends Component with KeyboardHandler {

  /// The speed of the player.
  static const double _speed = 60;

  /// The component to control for movement.
  final PositionComponent _transform;

  /// The current velocity of the player.
  final Vector2 _velocity = Vector2.zero();

  PlayerMovement(this._transform);

  /// Method called to update the position of the player to a new one within a
  /// direction and speed.
  @override
  void update(double dt) {
    _transform.position += _velocity * _speed * dt;
  }

  /// Method called when the keyboard is pressed. This will update the
  /// velocity of the player to move it in the correct direction.
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _velocity.setZero();

    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.keyW)) _velocity.y = -1;
      if (keysPressed.contains(LogicalKeyboardKey.keyS)) _velocity.y = 1;
      if (keysPressed.contains(LogicalKeyboardKey.keyA)) _velocity.x = -1;
      if (keysPressed.contains(LogicalKeyboardKey.keyD)) _velocity.x = 1;

      _velocity.normalize();
    }

    return true;
  }
}
