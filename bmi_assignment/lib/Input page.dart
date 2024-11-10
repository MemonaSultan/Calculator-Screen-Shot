import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String selectedGender = 'Male';

  // Placeholder calculateBMI function
  void calculateBMI() {
    // Add BMI calculation logic here
    print("BMI calculation executed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            // Gender selection with custom icons inside the boxes
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Male';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: selectedGender == 'Male' ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            color: selectedGender == 'Male' ? Colors.white : Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 22,
                              color: selectedGender == 'Male' ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = 'Female';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: selectedGender == 'Female' ? Colors.pinkAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            color: selectedGender == 'Female' ? Colors.white : Colors.black,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 22,
                              color: selectedGender == 'Female' ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Height input with custom increment/decrement icons inside the box
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Height (cm)', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int height = int.tryParse(heightController.text) ?? 0;
                                  heightController.text = (height - 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                            Expanded(
                              child: TextField(
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.height),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int height = int.tryParse(heightController.text) ?? 0;
                                  heightController.text = (height + 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Weight input with custom increment/decrement icons inside the box
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Weight (kg)', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int weight = int.tryParse(weightController.text) ?? 0;
                                  weightController.text = (weight - 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                            Expanded(
                              child: TextField(
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.fitness_center),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int weight = int.tryParse(weightController.text) ?? 0;
                                  weightController.text = (weight + 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                // Age input with custom increment/decrement icons inside the box
                Expanded(
                  child: Column(
                    children: [
                      Text('Age', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int age = int.tryParse(ageController.text) ?? 0;
                                  ageController.text = (age - 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                            Expanded(
                              child: TextField(
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.cake),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  int age = int.tryParse(ageController.text) ?? 0;
                                  ageController.text = (age + 1).toString();
                                });
                              },
                              iconSize: 30,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Bottom bar for the Calculate BMI button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
