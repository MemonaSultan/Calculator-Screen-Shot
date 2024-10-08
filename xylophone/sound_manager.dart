// lib/sound_manager.dart
import 'package:audioplayers/audioplayers.dart';
class SoundManager {
  final AudioPlayer _player = AudioPlayer();
  void playSound(int soundNumber) {
    _player.play('assets/not$soundNumber.wav');
  }
}