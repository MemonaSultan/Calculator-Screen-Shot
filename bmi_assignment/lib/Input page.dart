import 'package:flutter/material.dart';
import 'icontextfile.dart';

const Color activeColorMale = Color(0xFF1D83C7);
const Color activeColorFemale = Color(0xFF111328);
const Color deactiveColor = Colors.black54;

enum Gender { male, female }

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
  Gender selectedGender = Gender.male;

  void calculateBMI() {
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: selectedGender == Gender.male ? activeColorMale : deactiveColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            iconData: Icons.male,
                            color: selectedGender == Gender.male ? Colors.white : Colors.black,
                            size: 30,
                            onPressed: () {
                              setState(() {
                                selectedGender = Gender.male;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: 'Male',
                            style: TextStyle(
                              fontSize: 22,
                              color: selectedGender == Gender.male ? Colors.white : Colors.black,
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
                        selectedGender = Gender.female;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: selectedGender == Gender.female ? activeColorFemale : deactiveColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            iconData: Icons.female,
                            color: selectedGender == Gender.female ? Colors.white : Colors.black,
                            size: 30,
                            onPressed: () {
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: 'Female',
                            style: TextStyle(
                              fontSize: 22,
                              color: selectedGender == Gender.female ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                                  heightController.text = (height > 0 ? height - 1 : 0).toString();
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
            SizedBox(height: 20),
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
                                  weightController.text = (weight > 0 ? weight - 1 : 0).toString();
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
                                  ageController.text = (age > 0 ? age - 1 : 0).toString();
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
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 18),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
