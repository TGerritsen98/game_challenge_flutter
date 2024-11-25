import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_challenge_flutter/globals.dart';

/// Class representing the data of a creature type.
class CreatureData {

  /// The image file of the creature.
  final String _image;

  /// The sound file of the creature.
  final String _sound;

  /// The speed of the creature in movement.
  final double speed;

  CreatureData(this._image, this._sound, this.speed);

  /// Method to load in the image of the creature and convert it to a sprite
  /// sheet.
  FutureOr<SpriteSheet> sheet() async {
    return SpriteSheet(
        image: await Flame.images.load(_image),
        srcSize: Globals.spriteSize
    );
  }

  /// Method to play the sound effect of this creature.
  void play() {
    FlameAudio.play(_sound);
  }
}