import 'package:flame/components.dart';
import 'package:game_challenge_flutter/game_object.dart';

abstract class Scene extends Component {

  Map<String, List<GameObject>> tags = {};

  T addGameObject<T extends GameObject>(T gameObject) {
    if (gameObject.tag.isNotEmpty) {
      tags.putIfAbsent(gameObject.tag, () => []).add(gameObject);
    }

    gameObject.scene = this;

    add(gameObject);

    return gameObject;
  }

  T addGameObjectParent<T extends GameObject>(T gameObject, Component parent) {
    if (gameObject.tag.isNotEmpty) {
      tags.putIfAbsent(gameObject.tag, () => []).add(gameObject);
    }

    gameObject.scene = this;

    parent.add(gameObject);

    return gameObject;
  }

  GameObject? findWithTag(String tag) {
    final gameObjects = tags[tag];

    if (gameObjects != null && gameObjects.isNotEmpty) {
      return gameObjects.first;
    }

    return null;
  }
}