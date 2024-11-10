import 'package:flutter/material.dart';

import 'Input page.dart';
//import 'bmi_calculator.dart'; // Make sure this matches the filename of your BMI code file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}
