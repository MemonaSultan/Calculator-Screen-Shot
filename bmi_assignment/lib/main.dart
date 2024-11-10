import 'package:flutter/material.dart';
import 'Input page.dart';  // Correct path to Input page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),  // Make sure BMICalculator is being used here
    );
  }
}
