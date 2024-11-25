import 'package:flame/components.dart';

class CountdownTimer extends TextComponent {

  late double _remainingSeconds;
  bool _complete = false;
  Function? onComplete;

  CountdownTimer(double seconds, {super.position, super.anchor, super.scale, this.onComplete}) {
    _remainingSeconds = seconds;
    updateText();
  }

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

  void updateText() {
    text = _remainingSeconds.toStringAsFixed(2);
  }
}