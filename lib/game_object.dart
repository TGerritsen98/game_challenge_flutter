import 'package:flame/components.dart';
import 'package:game_challenge_flutter/scenes/scene.dart';

/// Class representing a game object within a [Scene]. A game object is able to
/// have multiple other [Component]s with their own functionality.
abstract class GameObject extends PositionComponent {

  /// The scene this game object is part of.
  Scene? scene;

  /// The tag of the game object for easy searching. This field should only be
  /// set in the constructor.
  String tag;

  GameObject({String? tag, super.position, super.anchor, super.priority}) : tag = tag ?? '';

  /// Method to add a [Component] to this game object.
  T append<T extends Component>(T component) {
    add(component);
    return component;
  }

  /// Method to add another [GameObject] to this game object.
  T addGameObject<T extends GameObject>(T object) {
    return scene!.addGameObjectParent(object, this);
  }
}