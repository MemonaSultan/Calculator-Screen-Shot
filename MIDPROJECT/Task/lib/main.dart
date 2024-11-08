import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class Task {
  String title;
  String description;
  DateTime time;
  bool isRepeated;
  List<String> repeatDays;
  bool isCompleted;
  double progress;

  Task({
    required this.title,
    required this.description,
    required this.time,
    this.isRepeated = false,
    this.repeatDays = const [],
    this.isCompleted = false,
    this.progress = 0.0,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Tasks'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskManagementPage()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Add Task Functionality
        },
      ),
    );
  }
}

class TaskManagementPage extends StatefulWidget {
  @override
  _TaskManagementPageState createState() => _TaskManagementPageState();
}

class _TaskManagementPageState extends State<TaskManagementPage> {
  final List<Task> tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedTime = DateTime.now();
  bool _isRepeated = false;
  List<String> _selectedDays = [];
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _notificationsPlugin.initialize(settings);
  }

  void _addTask() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      final newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        time: _selectedTime,
        isRepeated: _isRepeated,
        repeatDays: _selectedDays,
      );
      setState(() {
        tasks.add(newTask);
      });

      _titleController.clear();
      _descriptionController.clear();
    }
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void _editTask(Task task) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;
    setState(() {
      _selectedTime = task.time;
      _isRepeated = task.isRepeated;
      _selectedDays = task.repeatDays;
    });
  }

  // Function to generate PDF
  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    // Add the PDF content
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Task List', style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            for (var task in tasks)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Title: ${task.title}', style: pw.TextStyle(fontSize: 18)),
                  pw.Text('Description: ${task.description}', style: pw.TextStyle(fontSize: 16)),
                  pw.Text('Time: ${DateFormat('hh:mm a').format(task.time)}', style: pw.TextStyle(fontSize: 16)),
                  pw.Text('Completed: ${task.isCompleted ? "Yes" : "No"}', style: pw.TextStyle(fontSize: 16)),
                  pw.Divider(),
                ],
              ),
          ],
        );
      },
    ));

    // Print the PDF to the screen
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  void _showTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
              ListTile(
                title: Text('Pick Time'),
                subtitle: Text("${_selectedTime.hour}:${_selectedTime.minute}"),
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedTime),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedTime = DateTime(
                        _selectedTime.year,
                        _selectedTime.month,
                        _selectedTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                },
              ),
              SwitchListTile(
                title: Text('Repeat Task'),
                value: _isRepeated,
                onChanged: (value) {
                  setState(() {
                    _isRepeated = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _addTask();
                  Navigator.pop(context);
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,  // Call PDF function on press
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Completed Tasks'),
            trailing: Icon(Icons.check),
            onTap: () {
              // Show Completed Tasks
            },
          ),
          ListTile(
            title: Text('Today\'s Tasks'),
            trailing: Icon(Icons.today),
            onTap: () {
              // Show Today's Tasks
            },
          ),
          ListTile(
            title: Text('Repeated Tasks'),
            trailing: Icon(Icons.repeat),
            onTap: () {
              // Show Repeated Tasks
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(task);
                          _showTaskBottomSheet(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(task);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
