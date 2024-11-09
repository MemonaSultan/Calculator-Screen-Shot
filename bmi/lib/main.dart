import 'package:flutter/material.dart';
import 'dart:math'; // For quadratic equation solver

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String selectedCalculator = 'BMI Calculator';
  final List<String> calculators = [
    'BMI Calculator',
    'Tip Calculator',
    'Age Calculator',
    'Currency Converter',
    'Quadratic Equation Solver',
    'Temperature Converter',
    'Speed Distance Time Calculator',
    'Discount Calculator',
    'Fuel Efficiency Calculator',
  ];

  // Controllers for various input fields
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController billController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController fuelController = TextEditingController();
  TextEditingController coeffAController = TextEditingController();
  TextEditingController coeffBController = TextEditingController();
  TextEditingController coeffCController = TextEditingController();
  TextEditingController celsiusController = TextEditingController();

  // Currency converter variables
  TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'EUR';
  Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'INR': 73.5,
    'GBP': 0.75
  };
  String convertedAmount = '';

  // Results for various calculators
  String _bmiResult = '';
  String _tipResult = '';
  String _ageResult = '';
  String _finalPrice = '';
  String _fuelEfficiencyResult = '';
  String _quadraticRoots = '';
  String _tempConversionResult = '';
  String _speedDistanceTimeResult = '';

  // Methods for each calculator
  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    if (weight > 0 && height > 0) {
      double bmi = weight / pow(height, 2);
      setState(() {
        _bmiResult = "Your BMI is ${bmi.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _bmiResult = "Invalid input. Please enter valid weight and height.";
      });
    }
  }

  void calculateTip() {
    double bill = double.tryParse(billController.text) ?? 0;
    double tipPercent = double.tryParse(tipController.text) ?? 0;
    if (bill > 0 && tipPercent >= 0) {
      double tip = bill * (tipPercent / 100);
      setState(() {
        _tipResult = "Total with tip: ${(bill + tip).toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _tipResult =
        "Invalid input. Please enter valid bill and tip percentage.";
      });
    }
  }

  void calculateAge() {
    try {
      DateTime dob = DateTime.parse(dobController.text);
      DateTime today = DateTime.now();
      Duration difference = today.difference(dob);
      int years = difference.inDays ~/ 365;
      int months = (difference.inDays % 365) ~/ 30;
      int days = (difference.inDays % 365) % 30;
      setState(() {
        _ageResult = "$years years, $months months, $days days old";
      });
    } catch (e) {
      setState(() {
        _ageResult = "Invalid date. Please enter a valid date.";
      });
    }
  }

  void calculateDiscount() {
    double price = double.tryParse(priceController.text) ?? 0;
    double discount = double.tryParse(discountController.text) ?? 0;
    if (price > 0 && discount >= 0) {
      double finalPrice = price - (price * discount / 100);
      setState(() {
        _finalPrice = "Final Price: ${finalPrice.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _finalPrice =
        "Invalid input. Please enter valid price and discount percentage.";
      });
    }
  }

  void calculateFuelEfficiency() {
    double distance = double.tryParse(distanceController.text) ?? 0;
    double fuel = double.tryParse(fuelController.text) ?? 0;
    if (distance > 0 && fuel > 0) {
      double efficiency = distance / fuel;
      setState(() {
        _fuelEfficiencyResult =
        "Fuel Efficiency: ${efficiency.toStringAsFixed(2)} km/l";
      });
    } else {
      setState(() {
        _fuelEfficiencyResult =
        "Invalid input. Please enter valid distance and fuel.";
      });
    }
  }

  void solveQuadraticEquation() {
    double a = double.tryParse(coeffAController.text) ?? 0;
    double b = double.tryParse(coeffBController.text) ?? 0;
    double c = double.tryParse(coeffCController.text) ?? 0;
    if (a != 0) {
      double discriminant = b * b - 4 * a * c;
      if (discriminant < 0) {
        setState(() {
          _quadraticRoots = "No real roots";
        });
      } else {
        double root1 = (-b + sqrt(discriminant)) / (2 * a);
        double root2 = (-b - sqrt(discriminant)) / (2 * a);
        setState(() {
          _quadraticRoots =
          "Roots: ${root1.toStringAsFixed(2)}, ${root2.toStringAsFixed(2)}";
        });
      }
    } else {
      setState(() {
        _quadraticRoots = "Invalid input. Coefficient 'a' cannot be 0.";
      });
    }
  }

  void convertTemperature() {
    double celsius = double.tryParse(celsiusController.text) ?? 0;
    setState(() {
      _tempConversionResult =
      "Fahrenheit: ${(celsius * 9 / 5 + 32).toStringAsFixed(2)}, Kelvin: ${(celsius + 273.15).toStringAsFixed(2)}";
    });
  }

  void convertCurrency() {
    double amount = double.tryParse(amountController.text) ?? 0;
    double conversionRate = exchangeRates[selectedCurrency] ?? 1.0;
    if (amount > 0) {
      double converted = amount * conversionRate;
      setState(() {
        convertedAmount =
        "$amount USD = ${converted.toStringAsFixed(2)} $selectedCurrency";
      });
    } else {
      setState(() {
        convertedAmount = "Invalid input. Please enter a valid amount.";
      });
    }
  }

  // This widget builds the calculator UI based on selected option
  Widget buildCalculatorUI() {
    switch (selectedCalculator) {
      case 'BMI Calculator':
        return Column(
          children: [
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Height (m)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: calculateBMI, child: Text("Calculate BMI")),
            Text(_bmiResult),
          ],
        );
      case 'Tip Calculator':
        return Column(
          children: [
            TextField(
              controller: billController,
              decoration: InputDecoration(labelText: 'Bill Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: tipController,
              decoration: InputDecoration(labelText: 'Tip Percentage'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: calculateTip, child: Text("Calculate Tip")),
            Text(_tipResult),
          ],
        );
      case 'Age Calculator':
        return Column(
          children: [
            TextField(
              controller: dobController,
              decoration: InputDecoration(
                  labelText: 'Date of Birth (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            ElevatedButton(
                onPressed: calculateAge, child: Text("Calculate Age")),
            Text(_ageResult),
          ],
        );
      case 'Currency Converter':
        return Column(
          children: [
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount in USD'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: selectedCurrency,
              items: exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value ?? 'EUR';
                });
              },
            ),
            ElevatedButton(
                onPressed: convertCurrency, child: Text("Convert Currency")),
            Text(convertedAmount),
          ],
        );
      case 'Quadratic Equation Solver':
        return Column(
          children: [
            TextField(
              controller: coeffAController,
              decoration: InputDecoration(labelText: 'Coefficient a'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: coeffBController,
              decoration: InputDecoration(labelText: 'Coefficient b'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: coeffCController,
              decoration: InputDecoration(labelText: 'Coefficient c'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: solveQuadraticEquation,
                child: Text("Solve Equation")),
            Text(_quadraticRoots),
          ],
        );
      case 'Temperature Converter':
        return Column(
          children: [
            TextField(
              controller: celsiusController,
              decoration: InputDecoration(labelText: 'Temperature in Celsius'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: convertTemperature,
                child: Text("Convert Temperature")),
            Text(_tempConversionResult),
          ],
        );
      case 'Speed Distance Time Calculator':
        return Column(
          children: [
            TextField(
              controller: distanceController,
              decoration: InputDecoration(labelText: 'Distance (km)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time (hours)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: () {
              double distance = double.tryParse(distanceController.text) ?? 0;
              double time = double.tryParse(timeController.text) ?? 0;
              if (distance > 0 && time > 0) {
                double speed = distance / time;
                setState(() {
                  _speedDistanceTimeResult =
                  "Speed: ${speed.toStringAsFixed(2)} km/h";
                });
              } else {
                setState(() {
                  _speedDistanceTimeResult =
                  "Invalid input. Please enter valid distance and time.";
                });
              }
            }, child: Text("Calculate Speed")),
            Text(_speedDistanceTimeResult),
          ],
        );
      case 'Discount Calculator':
        return Column(
          children: [
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Original Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: discountController,
              decoration: InputDecoration(labelText: 'Discount Percentage'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: calculateDiscount,
                child: Text("Calculate Discount")),
            Text(_finalPrice),
          ],
        );
      case 'Fuel Efficiency Calculator':
        return Column(
          children: [
            TextField(
              controller: distanceController,
              decoration: InputDecoration(labelText: 'Distance (km)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: fuelController,
              decoration: InputDecoration(labelText: 'Fuel Used (liters)'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: calculateFuelEfficiency,
                child: Text("Calculate Efficiency")),
            Text(_fuelEfficiencyResult),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi-Calculator App"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[100]!, // Light pink
              Colors.blue[200]!, // Slightly darker blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCalculator,
              items: calculators.map((String calculator) {
                return DropdownMenuItem<String>(
                  value: calculator,
                  child: Text(calculator),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCalculator = value ?? 'BMI Calculator';
                });
              },
            ),
            Expanded(
              child: buildCalculatorUI(),
            ),
          ],
        ),
      ),
    );
  }
}
