import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  // Dice numbers for four dice
  int _diceNumber1 = 0;
  int _diceNumber2 = 0;
  int _diceNumber3 = 0;
  int _diceNumber4 = 0;

  // Button colors for each dice
  Color _buttonColor1 = Colors.red;
  Color _buttonColor2 = Colors.blue;
  Color _buttonColor3 = Colors.green;
  Color _buttonColor4 = Colors.pinkAccent;

  final List<Color> _colorList = [Colors.red, Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.deepOrangeAccent];

  // Keys for the dice widgets to track changes
  final _key1 = UniqueKey();
  final _key2 = UniqueKey();
  final _key3 = UniqueKey();
  final _key4 = UniqueKey();

  Color _randomColor() {
    return _colorList[Random().nextInt(_colorList.length)];
  }

  // Function to roll the first dice
  void _rollDice1() {
    setState(() {
      _diceNumber1 = Random().nextInt(6) + 1;
      _buttonColor1 = _randomColor();
    });
  }

  // Function to roll the second dice
  void _rollDice2() {
    setState(() {
      _diceNumber2 = Random().nextInt(6) + 1;
      _buttonColor2 = _randomColor();
    });
  }

  // Function to roll the third dice
  void _rollDice3() {
    setState(() {
      _diceNumber3 = Random().nextInt(6) + 1;
      _buttonColor3 = _randomColor();
    });
  }

  // Function to roll the fourth dice
  void _rollDice4() {
    setState(() {
      _diceNumber4 = Random().nextInt(6) + 1;
      _buttonColor4 = _randomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller with Animation'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First row: Dice 1 and Dice 2 with animation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Dice 1: $_diceNumber1',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Image.asset(
                          'images/dice-$_diceNumber1.png',
                          key: _key1, // Unique key for Dice 1
                          height: 100,
                        ),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _rollDice1,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor1,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text('Roll Dice 1'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Dice 2: $_diceNumber2',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Image.asset(
                          'images/dice-$_diceNumber2.png',
                          key: _key2, // Unique key for Dice 2
                          height: 100,
                        ),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _rollDice2,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor2,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text('Roll Dice 2'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Second row: Dice 3 and Dice 4 with animation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Dice 3: $_diceNumber3',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Image.asset(
                          'images/dice-$_diceNumber3.png',
                          key: _key3, // Unique key for Dice 3
                          height: 100,
                        ),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _rollDice3,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor3,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text('Roll Dice 3'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Dice 4: $_diceNumber4',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Image.asset(
                          'images/dice-$_diceNumber4.png',
                          key: _key4, // Unique key for Dice 4
                          height: 100,
                        ),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _rollDice4,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor4,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text('Roll Dice 4'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}