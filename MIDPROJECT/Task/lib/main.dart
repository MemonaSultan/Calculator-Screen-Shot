import 'package:flutter/material.dart';

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
            Image.asset(
              'Image/Image.png', // Replace with your image path
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
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
  List<String> _repeatDays = [];
  String? _alertMode;
  String? _selectedRingtone;
  int _snoozeTime = 5;

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
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Centered Add Alarm Button
                ElevatedButton(
                  onPressed: () {
                    // Handle Add Alarm action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alarm is set successfully!')),
                    );
                  },
                  child: Text('Add Alarm'),
                ),
                // Navigate to SaveTaskPage with task details
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaveTaskPage(
                          taskName: _nameController.text,
                          taskTime: _timeController.text,
                          taskLabel: _labelController.text,
                        ),
                      ),
                    );
                  },
                  child: Text('Save Task'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.task, color: Colors.white),
                labelText: 'Task Name',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.access_time, color: Colors.white),
                labelText: 'Time (HH:MM:SS)',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _labelController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.label, color: Colors.white),
                labelText: 'Label',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RepeatOptionPage(
                      onSelected: (option) {
                        setState(() {
                          _repeatOption = option;
                          _updateRepeatDays(option);
                        });
                      },
                      repeatDays: _repeatDays,
                      onDaysChanged: (days) {
                        setState(() {
                          _repeatDays = days;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.repeat, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Repeat Option: ', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 8),
                  Text(_repeatDays.isNotEmpty ? _repeatDays.join(', ') : 'None', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 10),
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
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _updateRepeatDays(String option) {
    if (option == 'Two-Day Weekly') {
      _repeatDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']; // Select Monday to Friday
    } else if (option == 'One-Day Weekly or Two-Day Weekly') {
      _repeatDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']; // Select Monday to Saturday
    } else {
      _repeatDays.clear(); // Clear the selection for other options
    }
  }

  void _selectRingtone() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Ringtone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _ringtones.map((ringtone) {
              return ListTile(
                title: Text(ringtone),
                leading: Icon(Icons.music_note),
                onTap: () {
                  setState(() {
                    _selectedRingtone = ringtone;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

// Save Task Page showing task details and actions
class SaveTaskPage extends StatelessWidget {
  final String taskName;
  final String taskTime;
  final String taskLabel;

  const SaveTaskPage({
    Key? key,
    required this.taskName,
    required this.taskTime,
    required this.taskLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Name: $taskName', style: TextStyle(fontSize: 20)),
            Text('Task Time: $taskTime', style: TextStyle(fontSize: 20)),
            Text('Task Label: $taskLabel', style: TextStyle(fontSize: 20)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Edit Task
                    Navigator.pop(context);
                    // You can also add your editing logic here
                  },
                  child: Text('Edit Task'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Delete Task
                    Navigator.pop(context);
                    // You can add your deletion logic here
                  },
                  child: Text('Delete Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Repeat Option Page
class RepeatOptionPage extends StatelessWidget {
  final Function(String) onSelected;
  final List<String> repeatDays;
  final Function(List<String>) onDaysChanged;

  const RepeatOptionPage({
    Key? key,
    required this.onSelected,
    required this.repeatDays,
    required this.onDaysChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeat Options')),
      body: ListView(
        children: [
          ListTile(
            title: Text('No Repeat'),
            onTap: () {
              onSelected('No Repeat');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Daily'),
            onTap: () {
              onSelected('Daily');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Weekly'),
            onTap: () {
              onSelected('Weekly');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Monthly'),
            onTap: () {
              onSelected('Monthly');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Custom'),
            onTap: () {
              onSelected('Custom');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
