import 'package:flutter/material.dart';
import 'icontextfile.dart';

// Define constants for active and deactive colors
const Color activeColorMale = Color(0xFF1D83C7); // Corrected color code
const Color activeColorFemale = Color(0xFF111328);
const Color deactiveColor = Colors.black54;

// Icon Widget Class
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

// Text Widget Class
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
        backgroundColor: Colors.black26,
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
                        color: selectedGender == 'Male' ? activeColorMale : deactiveColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            iconData: Icons.male,
                            color: selectedGender == 'Male' ? Colors.white : Colors.black,
                            size: 30,
                            onPressed: () {
                              setState(() {
                                selectedGender = 'Male';
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: 'Male',
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
                        color: selectedGender == 'Female' ? activeColorFemale : deactiveColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            iconData: Icons.female,
                            color: selectedGender == 'Female' ? Colors.white : Colors.black,
                            size: 30,
                            onPressed: () {
                              setState(() {
                                selectedGender = 'Female';
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: 'Female',
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
            SizedBox(height: 0),

            // Height input with custom increment/decrement icons inside the box
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Height (cm)',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconWidget(
                              iconData: Icons.remove_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int height = int.tryParse(heightController.text) ?? 0;
                                  heightController.text = (height - 1).toString();
                                });
                              },
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
                            IconWidget(
                              iconData: Icons.add_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int height = int.tryParse(heightController.text) ?? 0;
                                  heightController.text = (height + 1).toString();
                                });
                              },
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
                      TextWidget(
                        text: 'Weight (kg)',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconWidget(
                              iconData: Icons.remove_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int weight = int.tryParse(weightController.text) ?? 0;
                                  weightController.text = (weight - 1).toString();
                                });
                              },
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
                            IconWidget(
                              iconData: Icons.add_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int weight = int.tryParse(weightController.text) ?? 0;
                                  weightController.text = (weight + 1).toString();
                                });
                              },
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
                      TextWidget(
                        text: 'Age',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconWidget(
                              iconData: Icons.remove_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int age = int.tryParse(ageController.text) ?? 0;
                                  ageController.text = (age - 1).toString();
                                });
                              },
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
                            IconWidget(
                              iconData: Icons.add_circle_outline,
                              color: Colors.blueAccent,
                              size: 30,
                              onPressed: () {
                                setState(() {
                                  int age = int.tryParse(ageController.text) ?? 0;
                                  ageController.text = (age + 1).toString();
                                });
                              },
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

            // Calculate BMI button
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }
}
