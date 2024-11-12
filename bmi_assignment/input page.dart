import 'package:flutter/material.dart';
class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double? bmi;
  String classification = '';
  String selectedGender = 'Male';

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100;
      double result = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmi = result;
        classification = getBMICategory(bmi!, selectedGender);
      });
    }
  }

  String getBMICategory(double bmi, String gender) {
    // Categories can be adjusted slightly based on gender
    if (gender == 'Male') {
      if (bmi < 18.5) {
        return 'Underweight';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'Normal weight';
      } else if (bmi >= 25 && bmi < 29.9) {
        return 'Overweight';
      } else {
        return 'Obesity';
      }
    } else {
      // Assuming similar ranges for females, but they can be adjusted if needed
      if (bmi < 18.0) {
        return 'Underweight';
      } else if (bmi >= 18.0 && bmi < 24.0) {
        return 'Normal weight';
      } else if (bmi >= 24.0 && bmi < 29.0) {
        return 'Overweight';
      } else {
        return 'Obesity';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            if (bmi != null)
              Text(
                'Your BMI is ${bmi!.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 24),
              ),
            if (bmi != null)
              Text(
                classification,
                style: TextStyle(fontSize: 24, color: Colors.blueAccent),
              ),
          ],
        ),
      ),
    );
  }
}












