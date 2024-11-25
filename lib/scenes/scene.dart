import 'package:flame/components.dart';
import 'package:game_challenge_flutter/game_object.dart';

/// Class representing a scene in the game with multiple [GameObject]s and
/// [Component]s.
///
/// This class keeps track of the [GameObject]s with tags.
abstract class Scene extends Component {

  /// Map of all the tags with known [GameObject]s.
  final Map<String, List<GameObject>> _tags = {};

  /// Method to add a new [GameObject] to the scene. If the [GameObject] has a
  /// tag, this method will take that into account for later references.
  T addGameObject<T extends GameObject>(T gameObject) {
    return addGameObjectParent(gameObject, this);
  }

  /// Method to add a new [GameObject] to the a parent [Component], taking that
  /// into account tags of the [GameObject] for later references.
  T addGameObjectParent<T extends GameObject>(T gameObject, Component parent) {
    if (gameObject.tag.isNotEmpty) {
      _tags.putIfAbsent(gameObject.tag, () => []).add(gameObject);
    }

    gameObject.scene = this;

    parent.add(gameObject);

    return gameObject;
  }

  /// Method to find the first occurrence of a [GameObject] with the tag. If no
  /// [GameObject] has the tag, this method will return null.
  GameObject? findWithTag(String tag) {
    final gameObjects = _tags[tag];

    if (gameObjects != null && gameObjects.isNotEmpty) {
      return gameObjects.first;
    }

    return null;
  }
}