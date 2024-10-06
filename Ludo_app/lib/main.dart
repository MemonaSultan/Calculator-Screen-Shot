import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ludo App',
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

  // Scores and current turn/round
  int _score1 = 0;
  int _score2 = 0;
  int _score3 = 0;
  int _score4 = 0;
  int _round = 1;
  int _currentTurn = 1;

  // Dice animation controllers
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
    int rolledNumber = 0;

    switch (_currentTurn) {
      case 1:
        _controller1.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          rolledNumber = Random().nextInt(6) + 1;
          _diceNumber1 = rolledNumber;
          _score1 += rolledNumber;
          isSix = _diceNumber1 == 6;
        });
        break;
      case 2:
        _controller2.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          rolledNumber = Random().nextInt(6) + 1;
          _diceNumber2 = rolledNumber;
          _score2 += rolledNumber;
          isSix = _diceNumber2 == 6;
        });
        break;
      case 3:
        _controller3.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          rolledNumber = Random().nextInt(6) + 1;
          _diceNumber3 = rolledNumber;
          _score3 += rolledNumber;
          isSix = _diceNumber3 == 6;
        });
        break;
      case 4:
        _controller4.forward(from: 0);
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          rolledNumber = Random().nextInt(6) + 1;
          _diceNumber4 = rolledNumber;
          _score4 += rolledNumber;
          isSix = _diceNumber4 == 6;
        });
        break;
    }

    // Check if 5 rounds are complete
    if (_round >= 5) {
      _declareWinner();
    } else {
      // Move to the next turn
      if (!isSix) {
        setState(() {
          _currentTurn = (_currentTurn % 4) + 1; // Rotate between 1 to 4
          if (_currentTurn == 1) {
            _round++; // Increase round after player 4's turn
          }
        });
      }
    }
  }

  // Declare the winner
  void _declareWinner() {
    String winner;
    int highestScore = max(_score1, max(_score2, max(_score3, _score4)));

    if (highestScore == _score1) {
      winner = "Player 1 Wins!";
    } else if (highestScore == _score2) {
      winner = "Player 2 Wins!";
    } else if (highestScore == _score3) {
      winner = "Player 3 Wins!";
    } else {
      winner = "Player 4 Wins!";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Game Over"),
        content: Text(winner),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  // Reset the game
  void _resetGame() {
    setState(() {
      _diceNumber1 = 1;
      _diceNumber2 = 1;
      _diceNumber3 = 1;
      _diceNumber4 = 1;
      _score1 = 0;
      _score2 = 0;
      _score3 = 0;
      _score4 = 0;
      _round = 1;
      _currentTurn = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ludo App'),
        backgroundColor: Colors.blueGrey,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  'Player 1 : $_diceNumber1 (Score: $_score1)',
                  'images/dice-$_diceNumber1.png',
                  _animation1,
                  Colors.red,
                ),
                SizedBox(width: 50),
                _buildDiceColumn(
                  'Player 2 : $_diceNumber2 (Score: $_score2)',
                  'images/dice-$_diceNumber2.png',
                  _animation2,
                  Colors.green,
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiceColumn(
                  'Player 3 : $_diceNumber3 (Score: $_score3)',
                  'images/dice-$_diceNumber3.png',
                  _animation3,
                  Colors.blue,
                ),
                SizedBox(width: 50),
                _buildDiceColumn(
                  'Player 4 : $_diceNumber4 (Score: $_score4)',
                  'images/dice-$_diceNumber4.png',
                  _animation4,
                  Colors.yellow,
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
      String text, String imagePath, Animation<double> animation, Color color) {
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: color.withOpacity(0.8),
                ),
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  imagePath,
                  height: 100,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
