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
  List<String> _repeatDays = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Management')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.33, 0.66, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Task Name',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time (HH:MM)',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _labelController,
              decoration: InputDecoration(
                labelText: 'Label',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            DropdownButtonFormField(
              value: _alertMode,
              onChanged: (value) {
                setState(() => _alertMode = value as String);
              },
              items: ['Vibrate', 'Sound', 'Silent'].map((mode) {
                return DropdownMenuItem(value: mode, child: Text(mode));
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Alert Mode',
                labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16), // Add space between Alert Mode and Repeat Days
            Wrap(
              spacing: 8.0,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
                return ChoiceChip(
                  label: Text(day),
                  selected: _repeatDays.contains(day),
                  onSelected: (selected) {
                    setState(() {
                      selected ? _repeatDays.add(day) : _repeatDays.remove(day);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Add space between Repeat Days and Save Task button
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    // Create the task data
    final task = {
      'name': _nameController.text,
      'time': _timeController.text,
      'repeatDays': _repeatDays.join(', '),
      'alertMode': _alertMode,
      'label': _labelController.text,
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
    });
  }
}
