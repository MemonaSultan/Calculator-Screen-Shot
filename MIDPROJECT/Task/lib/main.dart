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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Task Name')),
            TextField(controller: _timeController, decoration: InputDecoration(labelText: 'Time (HH:MM)')),
            TextField(controller: _labelController, decoration: InputDecoration(labelText: 'Label')),
            DropdownButtonFormField(
              value: _alertMode,
              onChanged: (value) { setState(() => _alertMode = value as String); },
              items: ['Vibrate', 'Sound', 'Silent'].map((mode) {
                return DropdownMenuItem(value: mode, child: Text(mode));
              }).toList(),
              decoration: InputDecoration(labelText: 'Alert Mode'),
            ),
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
    final task = {
      'name': _nameController.text,
      'time': _timeController.text,
      'repeatDays': _repeatDays.join(', '),
      'alertMode': _alertMode,
      'label': _labelController.text,
    };
    await DBHelper.instance.insertTask(task);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Saved')));
  }
}
