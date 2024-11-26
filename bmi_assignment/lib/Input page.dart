import 'package:flutter/material.dart';

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
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  Gender selectedGender = Gender.male;

  // Function to change gender
  void selectGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void increaseValue(TextEditingController controller) {
    setState(() {
      int value = int.tryParse(controller.text) ?? 0;
      controller.text = (value + 1).toString();
    });
  }

  void decreaseValue(TextEditingController controller) {
    setState(() {
      int value = int.tryParse(controller.text) ?? 0;
      controller.text = (value - 1).toString();
    });
  }

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
            // Gender selection
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectGender(Gender.male);
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
                              selectGender(Gender.male);
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
                      selectGender(Gender.female);
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
                              selectGender(Gender.female);
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

            // Height input
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
                                decreaseValue(heightController);
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
                                increaseValue(heightController);
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

            // Weight input
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
                                decreaseValue(weightController);
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
                                increaseValue(weightController);
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
                                decreaseValue(ageController);
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
                                increaseValue(ageController);
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

            // Calculate BMI Button
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
                textStyle: TextStyle(fontSize: 20),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BMICalculator(),
  ));
}
