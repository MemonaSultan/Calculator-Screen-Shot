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

// Task Management Page with form and controls
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
                  Text(_repeatDays.isNotEmpty ? _repeatDays.join(', ') : 'None', style: TextStyle(color: Colors.white)),
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
                    Navigator.pop(context); // Navigate back to Home
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Create a new task
                    if (_nameController.text.isNotEmpty && _selectedTime != null) {
                      setState(() {
                        Task newTask = Task(
                          id: _totalTasksCount + 1,
                          name: _nameController.text,
                          time: _selectedTime!.format(context),
                          label: _labelController.text,
                        );
                        if (_repeatOption == "Custom") {
                          // Add to repeated tasks
                          _tasks.add(newTask);
                          _totalTasksCount++;
                        } else {
                          // Add to today tasks
                          _tasks.add(newTask);
                          _totalTasksCount++;
                        }
                      });

                      // Navigate to the task details page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(task: _tasks.last),
                        ),
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

  // Update the repeat days based on the repeat option
  void _updateRepeatDays(String option) {
    setState(() {
      if (option == 'Weekly') {
        _repeatDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      } else if (option == 'Bi-Weekly') {
        _repeatDays = ['Mon', 'Wed', 'Fri'];
      } else {
        _repeatDays = [];
      }
    });
  }

  // Select the time for the task
  void _selectTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  // Select a ringtone
  void _selectRingtone() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Ringtone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _ringtones.map((ringtone) {
              return ListTile(
                title: Text(ringtone),
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

// Task Details Page
class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Name: ${task.name}', style: TextStyle(fontSize: 18)),
            Text('Time: ${task.time}', style: TextStyle(fontSize: 18)),
            Text('Label: ${task.label}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
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

class RepeatOptionPage extends StatelessWidget {
  final Function(String) onSelected;
  final Function(List<String>) onDaysChanged;
  final List<String> repeatDays;

  RepeatOptionPage({required this.onSelected, required this.onDaysChanged, required this.repeatDays});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeat Option')),
      body: Column(
        children: [
          // Weekly, Bi-weekly, and Custom options
          ListTile(
            title: Text('Weekly'),
            onTap: () {
              onSelected('Weekly');
              onDaysChanged(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Bi-Weekly'),
            onTap: () {
              onSelected('Bi-Weekly');
              onDaysChanged(['Mon', 'Wed', 'Fri']);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Custom'),
            onTap: () {
              onSelected('Custom');
              onDaysChanged([]);
              Navigator.pop(context);
            },
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
      appBar: AppBar(title: Text('Today Tasks')),
      body: Center(child: Text('Tasks for Today')),
    );
  }
}

class CompletedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Center(child: Text('Completed Tasks')),
    );
  }
}

class RepeatedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repeated Tasks')),
      body: Center(child: Text('Repeated Tasks')),
    );
  }
}
