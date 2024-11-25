import 'dart:async';

import 'package:game_challenge_flutter/scenes/scene.dart';
import 'package:game_challenge_flutter/systems/health_system.dart';

class UIScene extends Scene {

  @override
  FutureOr<void> onLoad() {
    addGameObject(HealthSystem(3));
  }
}