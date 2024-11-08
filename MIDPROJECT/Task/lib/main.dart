import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(TaskManagementApp());
}

class Task {
  String title;
  String description;
  DateTime time;
  bool isCompleted;
  bool isRepeated;

  Task({
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
    this.isRepeated = false,
  });
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
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
          _showTaskBottomSheet(context); // Show the task bottom sheet
        },
      ),
    );
  }

  void _showTaskBottomSheet(BuildContext context, {Task? task}) {
    final _titleController = TextEditingController(text: task?.title);
    final _descriptionController = TextEditingController(text: task?.description);
    DateTime _selectedDate = task?.time ?? DateTime.now();
    TimeOfDay _selectedTime = TimeOfDay.fromDateTime(_selectedDate);
    bool isRepeated = task?.isRepeated ?? false;

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
                title: Text('Pick Date'),
                subtitle: Text("${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}"),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _selectedDate = pickedDate;
                  }
                },
              ),
              ListTile(
                title: Text('Pick Time'),
                subtitle: Text("${_selectedTime.hour}:${_selectedTime.minute}"),
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (pickedTime != null) {
                    _selectedTime = pickedTime;
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    );
                  }
                },
              ),
              SwitchListTile(
                title: Text('Repeat Task'),
                value: isRepeated,
                onChanged: (value) {
                  isRepeated = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final newTask = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    time: _selectedDate,
                    isRepeated: isRepeated,
                  );

                  Navigator.pop(context, newTask); // Save the task and pop the bottom sheet
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TaskManagementPage extends StatefulWidget {
  @override
  _TaskManagementPageState createState() => _TaskManagementPageState();
}

class _TaskManagementPageState extends State<TaskManagementPage> {
  final List<Task> todayTasks = [];
  final List<Task> completedTasks = [];
  final List<Task> repeatTasks = [];
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  // Initialize notifications
  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              _generatePdf();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTaskListTile('Today\'s Tasks', todayTasks, _markTaskAsCompleted, _deleteTask),
          _buildTaskListTile('Completed Tasks', completedTasks, null, _deleteTask),
          _buildTaskListTile('Repeat Tasks', repeatTasks, _markTaskAsCompleted, _deleteTask),
        ],
      ),
    );
  }

  Widget _buildTaskListTile(String title, List<Task> tasks, Function(Task)? onMarkCompleted, Function(Task) onDeleteTask) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskListPage(
              title: title,
              tasks: tasks,
              onMarkCompleted: onMarkCompleted,
              onEditTask: _editTask,
              onDeleteTask: onDeleteTask,
            ),
          ),
        );
      },
    );
  }

  void _markTaskAsCompleted(Task task) {
    setState(() {
      todayTasks.remove(task); // Remove from Today Tasks
      task.isCompleted = true;
      completedTasks.add(task); // Add to Completed Tasks
    });

    // Show notification when task is marked as completed
    _showNotification(
      title: 'Task Completed',
      body: 'The task "${task.title}" is now completed.',
    );
  }

  void _editTask(Task task) {
    _showTaskBottomSheet(context, task: task); // Pass the task to the bottom sheet for editing
  }

  void _deleteTask(Task task) {
    setState(() {
      todayTasks.remove(task);
      repeatTasks.remove(task);
      completedTasks.remove(task);
    });

    // Show notification when task is deleted
    _showNotification(
      title: 'Task Deleted',
      body: 'The task "${task.title}" has been deleted.',
    );
  }

  // Show notification function
  Future<void> _showNotification({required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'item x',
    );
  }

  // PDF Generation
  void _generatePdf() async {
    final pdf = pw.Document();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/tasks.pdf');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Today\'s Tasks', style: pw.TextStyle(fontSize: 24)),
              ...todayTasks.map((task) => pw.Text(task.title)),
              pw.SizedBox(height: 20),
              pw.Text('Completed Tasks', style: pw.TextStyle(fontSize: 24)),
              ...completedTasks.map((task) => pw.Text(task.title)),
              pw.SizedBox(height: 20),
              pw.Text('Repeat Tasks', style: pw.TextStyle(fontSize: 24)),
              ...repeatTasks.map((task) => pw.Text(task.title)),
            ],
          );
        },
      ),
    );

    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to ${file.path}')),
    );
  }

  void _showTaskBottomSheet(BuildContext context, {required Task task}) {}
}

class TaskListPage extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Function(Task)? onMarkCompleted;
  final Function(Task) onEditTask;
  final Function(Task) onDeleteTask;

  TaskListPage({
    required this.title,
    required this.tasks,
    this.onMarkCompleted,
    required this.onEditTask,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onMarkCompleted != null)
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => onMarkCompleted!(task),
                  ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEditTask(task),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDeleteTask(task),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
