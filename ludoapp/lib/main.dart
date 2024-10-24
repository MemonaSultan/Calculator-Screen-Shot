import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> with TickerProviderStateMixin {
  // Dice values
  int _diceNumber1 = 1;
  int _diceNumber2 = 1;
  int _diceNumber3 = 1;
  int _diceNumber4 = 1;

  int _currentTurn = 1; // Start with Player 1's turn

  late AnimationController _controller1;
  late Animation<double> _animation1;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  late AnimationController _controller3;
  late Animation<double> _animation3;

  late AnimationController _controller4;
  late Animation<double> _animation4;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation1 = Tween<double>(begin: 0, end: 2 * pi).animate(_controller1);

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation2 = Tween<double>(begin: 0, end: 2 * pi).animate(_controller2);

    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation3 = Tween<double>(begin: 0, end: 2 * pi).animate(_controller3);

    _controller4 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation4 = Tween<double>(begin: 0, end: 2 * pi).animate(_controller4);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  // Roll dice based on the current turn
  void _rollDice() async {
    bool isSix = false;

    switch (_currentTurn) {
      case 1:
        _controller1.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          _diceNumber1 = Random().nextInt(6) + 1;
          isSix = _diceNumber1 == 6;
        });
        break;
      case 2:
        _controller2.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          _diceNumber2 = Random().nextInt(6) + 1;
          isSix = _diceNumber2 == 6;
        });
        break;
      case 3:
        _controller3.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          _diceNumber3 = Random().nextInt(6) + 1;
          isSix = _diceNumber3 == 6;
        });
        break;
      case 4:
        _controller4.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          _diceNumber4 = Random().nextInt(6) + 1;
          isSix = _diceNumber4 == 6;
        });
        break;
    }

    // If dice result is not 6, move to the next player's turn
    if (!isSix) {
      setState(() {
        _currentTurn = (_currentTurn % 4) + 1; // Rotate between 1 to 4
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
        backgroundColor: Colors.black, // Changed background color of AppBar to black
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Changed text color to white for better contrast
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey, // Background color remains grey
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  'Player 1 : $_diceNumber1',
                  'images/dice-$_diceNumber1.png', // Ensure these images are darker grey
                  _animation1,
                  1,
                ),
                SizedBox(width: 50),
                _buildDiceColumn(
                  'Player 2 : $_diceNumber2',
                  'images/dice-$_diceNumber2.png', // Ensure these images are darker grey
                  _animation2,
                  2,
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  'Player 3 : $_diceNumber3',
                  'images/dice-$_diceNumber3.png', // Ensure these images are darker grey
                  _animation3,
                  3,
                ),
                SizedBox(width: 50),
                _buildDiceColumn(
                  'Player 4 : $_diceNumber4',
                  'images/dice-$_diceNumber4.png', // Ensure these images are darker grey
                  _animation4,
                  4,
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _rollDice,
              child: Text('Roll Dice for Player $_currentTurn'),
            ),
          ],
        ),
      ),
    );
  }

  // Build each dice column with player roll result, image, and roll button
  Widget _buildDiceColumn(
      String text, String imagePath, Animation<double> animation, int playerNumber) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value,
              child: Image.asset(
                imagePath,
                height: 100,
              ),
            );
          },
        ),
      ],
    );
  }
}
