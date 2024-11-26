import 'package:flutter/material.dart';
import 'icontextfile.dart';
import 'package:bmi_assignment/containerfile.dart';
class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String selectedGender = 'Male';
  void calculateBMI() {
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
                        color: selectedGender == 'Female' ? Colors.pinkAccent : Colors.grey[300],
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
            SizedBox(height: 30),
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                ),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

