import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _labelController = TextEditingController();
  String? _alertMode;
  String? _selectedRingtone; // Selected ringtone variable
  List<String> _repeatDays = [];
  String _repeatOption = "Custom";
  int _snoozeTime = 5; // Snooze time limit in seconds

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
                labelText: 'Time (HH:MM)',
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

            // Separate Ringtone Selection Button
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

            SizedBox(height: 16),

            // Repeat Option Dropdown with Icon
            DropdownButtonFormField(
              value: _repeatOption,
              onChanged: (value) {
                setState(() => _repeatOption = value as String);
              },
              items: ['Two-day weekend', 'One-day or two-day weekend', 'Shift system', 'Custom'].map((option) {
                return DropdownMenuItem(value: option, child: Text(option));
              }).toList(),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.repeat, color: Colors.white),
                labelText: 'Repeat Option',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 16),

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

            SizedBox(height: 20),

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

            SizedBox(height: 20),

            // Save Task Button with Icon
            ElevatedButton.icon(
              onPressed: _saveTask,
              icon: Icon(Icons.save, color: Colors.white),
              label: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle ringtone selection
  void _selectRingtone() async {
    // Logic for ringtone selection (placeholder for now)
    // In a real app, you'd open a dialog or use an API to pick a ringtone
    setState(() {
      _selectedRingtone = 'Default Ringtone'; // Example selected ringtone
    });
  }

  Future<void> _saveTask() async {
    // Create the task data
    final task = {
      'name': _nameController.text,
      'time': _timeController.text,
      'repeatDays': _repeatDays.join(', '),
      'alertMode': _alertMode,
      'label': _labelController.text,
      'repeatOption': _repeatOption,
      'snoozeTime': _snoozeTime,
      'ringtone': _selectedRingtone, // Save selected ringtone
    };

    // Insert task to the database
    await DBHelper.instance.insertTask(task);

    // Show SnackBar message
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task Saved'))
    );

    // Clear the form fields after saving
    _nameController.clear();
    _timeController.clear();
    _labelController.clear();
    setState(() {
      _alertMode = null;
      _repeatDays.clear();
      _repeatOption = "Custom";
      _selectedRingtone = null;
      _snoozeTime = 5;
    });
  }
}
