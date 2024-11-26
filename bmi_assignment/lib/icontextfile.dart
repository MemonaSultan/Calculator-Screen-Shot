import 'package:flutter/material.dart';
class IconWidget extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double size;
  final VoidCallback onPressed;

  IconWidget({
    required this.iconData,
    required this.color,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
      iconSize: size,
      color: color,
    );
  }
}
class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;

  TextWidget({
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}