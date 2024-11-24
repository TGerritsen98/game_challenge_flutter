import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_challenge_flutter/globals.dart';

class CreatureData {

  final String _image;
  final String _sound;
  final double speed;

  CreatureData(this._image, this._sound, this.speed);

  FutureOr<SpriteSheet> sheet() async {
    return SpriteSheet(
        image: await Flame.images.load(_image),
        srcSize: Globals.spriteSize
    );
  }

  void play() {
    FlameAudio.play(_sound);
  }
}