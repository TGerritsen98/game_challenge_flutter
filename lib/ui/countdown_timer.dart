import 'package:flame/components.dart';

/// Class representing a text upon the screen that counts down.
class CountdownTimer extends TextComponent {

  /// The currently remaining seconds.
  late double _remainingSeconds;

  /// True when the countdown has completed, otherwise false.
  bool _complete = false;

  /// The function to call when the countdown has completed.
  Function? onComplete;

  CountdownTimer(double seconds, {super.position, super.anchor, super.scale, this.onComplete}) {
    _remainingSeconds = seconds;
    updateText();
  }

  /// Method to update the countdown. If the countdown has already completed,
  /// it will do nothing.
  ///
  /// When the countdown reaches 0, it will trigger the [onComplete] function.
  @override
  void update(double dt) {
    if (_complete) return;

    _remainingSeconds -= dt;

    if (_remainingSeconds < 0) {
      _remainingSeconds = 0;
      _complete = true;

      onComplete?.call();
    }

    updateText();
  }

  /// Method to update the text visible in the game with the remaining seconds.
  void updateText() {
    text = _remainingSeconds.toStringAsFixed(2);
  }
}