import 'package:flutter/material.dart';
import 'input page.dart';
void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
        home: BMICalculator(),
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
        )

      //),

     // theme:ThemeData.dart(),
    );
  }
}

