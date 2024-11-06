import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Task Options',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Today Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodayTaskPage()),
                );
              },
            ),
            ListTile(
              title: Text('Completed Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompletedTaskPage()),
                );
              },
            ),
            ListTile(
              title: Text('Repeated Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RepeatedTaskPage()),
                );
              },
            ),
          ],
        ),
      ),
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
              label: Text('Start Task'),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _nameController = TextEditingController();
  final _labelController = TextEditingController();
  String _repeatOption = "Custom";
  List<String> _repeatDays = [];
  String? _alertMode;
  String? _selectedRingtone;
  int _completedTasksCount = 0;
  int _totalTasksCount = 0;
  List<Task> _tasks = [];

  TimeOfDay? _selectedTime;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, String>> _ringtones = [
    {'name': 'digital_trills', 'path': 'assets/ringtones/digital_trills.mp3'},
    {'name': 'german 1', 'path': 'assets/ringtones/german_bell.mp3'},
    {'name': 'stacked 2', 'path': 'assets/ringtones/stacked.mp3'},
    {'name': 'twinkling 3', 'path': 'assets/ringtones/twinkling.mp3'},
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

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
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.task, color: Colors.white),
                labelText: 'Task Name',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: _selectTime,
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                      text: _selectedTime != null
                          ? _selectedTime!.format(context)
                          : 'Select Time'),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time, color: Colors.white),
                    labelText: 'Time (HH:MM)',
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                ),
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
                  Text(_repeatDays.isNotEmpty ? _repeatDays.join(', ') : '', style: TextStyle(color: Colors.white)),
                ],
              ),
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
            SizedBox(height: 16),
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
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _totalTasksCount == 0 ? 0 : _completedTasksCount / _totalTasksCount,
              backgroundColor: Colors.white,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Code to create a new task and handle task functionality.
                    if (_nameController.text.isNotEmpty && _selectedTime != null) {
                      setState(() {
                        Task newTask = Task(
                          id: _totalTasksCount + 1,
                          name: _nameController.text,
                          time: _selectedTime!.format(context),
                          label: _labelController.text,
                        );
                        if (_repeatOption == "Custom") {
                          _tasks.add(newTask);
                          _totalTasksCount++;
                        } else {
                          _tasks.add(newTask);
                          _totalTasksCount++;
                        }
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TodayTaskPage()),
                      );
                    }
                  },
                  child: Text('Save Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _selectRingtone() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _ringtones.length,
          itemBuilder: (context, index) {
            final ringtone = _ringtones[index];
            return ListTile(
              title: Text(ringtone['name']!),
              onTap: () async {
                _audioPlayer.stop();
                await _audioPlayer.play(ringtone['path']!, isLocal: true);
                setState(() {
                  _selectedRingtone = ringtone['name'];
                });
              },
            );
          },
        );
      },
    );
  }

  void _updateRepeatDays(String option) {
    if (option == 'Daily') {
      _repeatDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    } else if (option == 'Bi-weekly') {
      _repeatDays = ['Sun', 'Tue', 'Thu', 'Sat'];
    } else {
      _repeatDays = [];
    }
  }
}

class RepeatOptionPage extends StatefulWidget {
  final ValueChanged<String> onSelected;
  final ValueChanged<List<String>> onDaysChanged;
  final List<String> repeatDays;

  RepeatOptionPage({
    required this.onSelected,
    required this.repeatDays,
    required this.onDaysChanged,
  });

  @override
  _RepeatOptionPageState createState() => _RepeatOptionPageState();
}

class _RepeatOptionPageState extends State<RepeatOptionPage> {
  final List<String> _days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  String _selectedOption = 'Custom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeat Options')),
      body: Column(
        children: [
          ListTile(
            title: Text('Daily'),
            leading: Radio<String>(
              value: 'Daily',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() => _selectedOption = value!);
                widget.onSelected('value');
                widget.onDaysChanged(_days);
              },
            ),
          ),
          ListTile(
            title: Text('Bi-weekly'),
            leading: Radio<String>(
              value: 'Bi-weekly',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() => _selectedOption = value!);
                widget.onSelected('value');
                widget.onDaysChanged(['Sun', 'Tue', 'Thu', 'Sat']);
              },
            ),
          ),
          ListTile(
            title: Text('Custom'),
            leading: Radio<String>(
              value: 'Custom',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() => _selectedOption = value!);
                widget.onSelected('value');
                widget.onDaysChanged([]);
              },
            ),
          ),
          if (_selectedOption == 'Custom')
            Wrap(
              spacing: 8,
              children: _days
                  .map((day) => ChoiceChip(
                label: Text(day),
                selected: widget.repeatDays.contains(day),
                onSelected: (isSelected) {
                  setState(() {
                    isSelected
                        ? widget.repeatDays.add(day)
                        : widget.repeatDays.remove(day);
                  });
                  widget.onDaysChanged(widget.repeatDays);
                },
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class TodayTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Today’s Tasks')),
      body: Center(child: Text('Tasks for today will be displayed here')),
    );
  }
}

class CompletedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Center(child: Text('Completed tasks will be displayed here')),
    );
  }
}

class RepeatedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeated Tasks')),
      body: Center(child: Text('Repeated tasks will be displayed here')),
    );
  }
}

class Task {
  final int id;
  final String name;
  final String time;
  final String label;

  Task({required this.id, required this.name, required this.time, required this.label});
}
