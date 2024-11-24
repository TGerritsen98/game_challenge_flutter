import 'package:flame/components.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';

abstract class GameObject extends PositionComponent {

  /// The scene this game object is part of.
  Scene? scene;

  /// The tag of the game object for easy searching. This field should only be
  /// set in the constructor.
  String tag = "";

  T append<T extends Component>(T component) {
    add(component);
    return component;
  }

  T addGameObject<T extends GameObject>(T object) {
    return scene!.addGameObjectParent(object, this);
  }
}