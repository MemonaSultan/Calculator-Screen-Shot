import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';  // Import color picker

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophoneHomePage(),
    );
  }
}

class XylophoneHomePage extends StatefulWidget {
  @override
  _XylophoneHomePageState createState() => _XylophoneHomePageState();
}

class _XylophoneHomePageState extends State<XylophoneHomePage> {
  final AudioCache _audioCache = AudioCache();
  final List<Color> _keyColors = List.generate(6, (index) => Colors.white); // 6 keys only
  final List<int> _soundNumbers = List.generate(6, (index) => index + 1);
  final List<bool> _isPressed = List.generate(6, (index) => false); // Track if the key is pressed

  void playSound(int soundNumber) {
    _audioCache.play('note$soundNumber.wav');  // Ensure note sounds are in assets
  }

  void changeKeyColor(int index, Color color) {
    setState(() {
      _keyColors[index] = color;
    });
  }

  void changeSound(int index, int soundNumber) {
    setState(() {
      _soundNumbers[index] = soundNumber;
    });
  }

  Widget buildKey(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            playSound(_soundNumbers[index]);
            setState(() {
              _isPressed[index] = true;  // Set to true when pressed
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressed[index] = false;  // Reset to false after pressing
            });
          },
          child: Transform.scale(
            scale: _isPressed[index] ? 1.1 : 1.0,  // Scale up on press
            child: Container(
              margin: EdgeInsets.all(5),  // Add some margin for better spacing
              color: _keyColors[index],
              height: 80, // Height for each key
              child: Center(
                child: Text(
                  'Key ${index + 1}',  // Display key number
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        // Now place the color and sound buttons below each key
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () => openColorPicker(index),
            ),
            IconButton(
              icon: Icon(Icons.music_note),
              onPressed: () => openSoundPicker(index),
            ),
          ],
        ),
      ],
    );
  }

  void openColorPicker(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose color for Key ${index + 1}'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _keyColors[index],
              onColorChanged: (color) {
                changeKeyColor(index, color);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void openSoundPicker(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose sound for Key ${index + 1}'),
          content: DropdownButton<int>(
            value: _soundNumbers[index],
            items: List.generate(
              6,
                  (i) => DropdownMenuItem(
                child: Text('Sound ${i + 1}'),
                value: i + 1,
              ),
            ),
            onChanged: (value) {
              changeSound(index, value ?? 1);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customized Xylophone',
          style: TextStyle(color: Colors.white),  // Title text color
        ),
        backgroundColor: Colors.grey[800],  // Dark grey background for the AppBar
      ),
      body: SingleChildScrollView(  // Wrap the entire body in a scroll view to avoid overflow
        child: Container(
          color: Colors.grey,  // Set background color to grey
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              6,
                  (index) => buildKey(index),  // Display keys with buttons below
            ),
          ),
        ),
      ),
    );
  }
}
