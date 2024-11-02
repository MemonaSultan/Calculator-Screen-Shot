import 'package:flutter/material.dart';
import 'db_helper.dart'; // Ensure you have this file for database handling.

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page with "Start Task" button and an image
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the image
            Image.asset(
              'Image/alarm.png', // Replace with your image path
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 20), // Space between image and button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to TaskPage when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskPage()),
                );
              },
              icon: Icon(Icons.play_arrow),
              label: Text('Start Task'),
            ),
          ],
        ),
      ),
    );
  }
}

// Task Management Page with form and controls
class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _labelController = TextEditingController();
  String _repeatOption = "Custom";

  // List to hold selected days
  List<String> _repeatDays = []; // Store selected days

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Management')),
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Task Name Field with Icon
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.task, color: Colors.white),
                labelText: 'Task Name',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            // Time Field with Icon
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.access_time, color: Colors.white),
                labelText: 'Time (HH:MM:sec)',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            // Label Field with Icon
            TextField(
              controller: _labelController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.label, color: Colors.white),
                labelText: 'Label',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 16),

            // Repeat Option Dropdown
            DropdownButtonFormField(
              value: _repeatOption,
              onChanged: (value) {
                setState(() => _repeatOption = value as String);
              },
              items: [
                'Two-day weekend',
                'One-day or two-day weekend',
                'Shift system',
                'Custom',
              ].map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.repeat, color: Colors.white),
                labelText: 'Repeat Option',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20), // Space before days selection

            // Customize Reminder Cycle with Day Chips and Icons
            if (_repeatOption == 'Custom')
              Wrap(
                spacing: 8.0,
                children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
                  return ChoiceChip(
                    avatar: Icon(Icons.calendar_today, size: 20, color: Colors.white),
                    label: Text(day),
                    selected: _repeatDays.contains(day),
                    selectedColor: Colors.blue,
                    onSelected: (selected) {
                      setState(() {
                        selected ? _repeatDays.add(day) : _repeatDays.remove(day);
                      });
                    },
                  );
                }).toList(),
              ),

            SizedBox(height: 20), // Space before alarm buttons

            // Alarm Done and Alarm Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Alarm Done action
                  },
                  child: Text('Alarm Done'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Alarm Cancel action
                  },
                  child: Text('Alarm Cancel'),
                ),
              ],
            ),

            SizedBox(height: 20), // Space before the settings button

            // Navigate to Settings Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Page for ringtone, alert mode, and snooze time
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _alertMode;
  String? _selectedRingtone;
  int _snoozeTime = 5;

  // Sample list of ringtones
  final List<String> _ringtones = [
    'Default Ringtone',
    'Ringtone 1',
    'Ringtone 2',
    'Ringtone 3',
    'Ringtone 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Alert Mode Dropdown with Icon
            DropdownButtonFormField(
              value: _alertMode,
              onChanged: (value) {
                setState(() => _alertMode = value as String);
              },
              items: [
                DropdownMenuItem(
                  value: 'Vibrate',
                  child: Row(
                    children: [
                      Icon(Icons.vibration, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Vibrate'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Sound',
                  child: Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Sound'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Silent',
                  child: Row(
                    children: [
                      Icon(Icons.notifications_off, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Silent'),
                    ],
                  ),
                ),
              ],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.notifications, color: Colors.white),
                labelText: 'Alert Mode',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 16),

            // Ringtone Selection Row
            Row(
              children: [
                Icon(Icons.ring_volume, color: Colors.white),
                SizedBox(width: 8),
                Text('Ringtone: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Spacer(),
                ElevatedButton(
                  onPressed: _selectRingtone,
                  child: Text(_selectedRingtone ?? 'Select Ringtone'),
                ),
              ],
            ),

            SizedBox(height: 16), // Space between ringtone and snooze option

            // Snooze Time Setting Row with Slider
            Row(
              children: [
                Icon(Icons.snooze, color: Colors.white),
                SizedBox(width: 8),
                Text('Snooze Time: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Slider(
                    value: _snoozeTime.toDouble(),
                    min: 5,
                    max: 60,
                    divisions: 11,
                    label: '$_snoozeTime sec',
                    onChanged: (value) {
                      setState(() {
                        _snoozeTime = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle ringtone selection
  void _selectRingtone() async {
    // Show the ringtone selection dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Ringtone'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _ringtones.map((ringtone) {
                return ListTile(
                  title: Text(ringtone),
                  onTap: () {
                    setState(() {
                      _selectedRingtone = ringtone; // Update selected ringtone
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
