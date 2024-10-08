// lib/xylophone_key.dart
import 'package:flutter/material.dart';
import 'sound_manager.dart';
class XylophoneKey extends StatelessWidget {
  final Color color;
  final int soundNumber;
  final SoundManager soundManager;
  XylophoneKey({
    required this.color,
    required this.soundNumber,
    required this.soundManager,
  });
  void handlePress() {
    soundManager.playSound(soundNumber);
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: handlePress,
        child: Container(),
      ),
    );
  }
}