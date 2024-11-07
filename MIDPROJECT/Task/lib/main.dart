import 'package:flutter/material.dart';

// Task model for managing task details
class Task {
  String title;
  String description;
  DateTime time;
  bool isRepeated;
  List<String> repeatDays; // List to store selected repeat days
  bool isCompleted; // Track completion status
  double progress; // Track task completion progress

  Task({
    required this.title,
    required this.description,
    required this.time,
    this.isRepeated = false,
    this.repeatDays = const [],
    this.isCompleted = false, // Task is initially not completed
    this.progress = 0.0, // Initial progress is 0
  });
}

// TodayTaskPage with Add Task functionality and Delete Task
class TodayTaskPage extends StatefulWidget {
  final Function(Task) onCompleteTask;
  final Function(Task) onRepeatTask;

  TodayTaskPage({required this.onCompleteTask, required this.onRepeatTask});

  @override
  _TodayTaskPageState createState() => _TodayTaskPageState();
}

class _TodayTaskPageState extends State<TodayTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedTime = DateTime.now();
  bool _isRepeated = false;
  List<String> _selectedDays = [];
  List<Task> _tasks = []; // List to store tasks
  Task? _currentTask; // Store the current task being edited

  // Function to handle the "Save Task" button click
  void _saveTask() {
    if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
      final newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        time: _selectedTime,
        isRepeated: _isRepeated,
        repeatDays: _selectedDays, // Save the selected repeat days
        isCompleted: false, // Task is initially not completed
        progress: 0.0, // Initially 0% progress
      );
      setState(() {
        _tasks.add(newTask); // Add task to the list
        _currentTask = newTask; // Set the current task to show in the AppBar
      });

      // If the task is marked as repeated, call onRepeatTask to move it to the RepeatedTasks page
      if (_isRepeated) {
        widget.onRepeatTask(newTask); // Move task to repeated tasks
      }

      // Clear the form after saving the task
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedTime = DateTime.now();
        _isRepeated = false;
        _selectedDays.clear();
      });
    }
  }

  // Function to handle task deletion
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove the task at the given index
    });
  }

  // Function to handle task completion
  void _completeTask(Task task) {
    setState(() {
      // Add the task to the completed tasks list
      widget.onCompleteTask(task);
      _tasks.remove(task); // Remove from today's task list
    });
  }

  // Function to show time picker
  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute),
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
  }

  // Function to show bottom sheet with task details form
  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Task Title Text Field
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Task Title",
                ),
              ),
              // Task Description Text Field
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Task Description",
                ),
              ),
              // Time Picker
              ListTile(
                title: Text("Pick Time"),
                subtitle: Text("${_selectedTime.hour}:${_selectedTime.minute}"),
                onTap: _pickTime,
              ),
              // Repeat Option
              SwitchListTile(
                title: Text("Repeat Task"),
                value: _isRepeated,
                onChanged: (bool value) {
                  setState(() {
                    _isRepeated = value;
                    if (_isRepeated) {
                      // Navigate to RepeatOptionPage when switching on
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepeatOptionPage(
                            onDaysSelected: (selectedDays) {
                              setState(() {
                                _selectedDays = selectedDays;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
              // Save Task Button
              ElevatedButton(
                onPressed: _saveTask,
                child: Text("Save Task"),
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
        title: Text('Today Tasks'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("${task.description}\n${task.time.hour}:${task.time.minute}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                task.isCompleted
                    ? Icon(Icons.check, color: Colors.green) // Show check mark for completed task
                    : IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    _completeTask(task); // Move the task to completed tasks
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteTask(index); // Delete the task when the delete icon is pressed
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}

// Define the CompletedTaskPage
class CompletedTaskPage extends StatelessWidget {
  final List<Task> completedTasks;

  CompletedTaskPage({required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final task = completedTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("${task.description}\n${task.time.hour}:${task.time.minute}"),
            trailing: Icon(Icons.check, color: Colors.green),
          );
        },
      ),
    );
  }
}

// Define the RepeatedTaskPage
class RepeatedTaskPage extends StatelessWidget {
  final List<Task> repeatedTasks;

  RepeatedTaskPage({required this.repeatedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repeated Tasks'),
      ),
      body: ListView.builder(
        itemCount: repeatedTasks.length,
        itemBuilder: (context, index) {
          final task = repeatedTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text("${task.description}\n${task.time.hour}:${task.time.minute}"),
          );
        },
      ),
    );
  }
}

// Define the RepeatOptionPage for selecting repeat days
class RepeatOptionPage extends StatelessWidget {
  final Function(List<String>) onDaysSelected;

  RepeatOptionPage({required this.onDaysSelected});

  @override
  Widget build(BuildContext context) {
    List<String> repeatDays = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Repeat Options"),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text("Monday"),
            value: repeatDays.contains("Monday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Monday");
              } else {
                repeatDays.remove("Monday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("Tuesday"),
            value: repeatDays.contains("Tuesday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Tuesday");
              } else {
                repeatDays.remove("Tuesday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("wednesday"),
            value: repeatDays.contains("wednesday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("wednesday");
              } else {
                repeatDays.remove("wednesday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("Tursday"),
            value: repeatDays.contains("Tursday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Thursday");
              } else {
                repeatDays.remove("Thursday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("Friday"),
            value: repeatDays.contains("Friday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Friday");
              } else {
                repeatDays.remove("Friday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("Saturday"),
            value: repeatDays.contains("Saturday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Saturday");
              } else {
                repeatDays.remove("Saturday");
              }
            },
          ),
          CheckboxListTile(
            title: Text("Sunday"),
            value: repeatDays.contains("Sunday"),
            onChanged: (bool? value) {
              if (value == true) {
                repeatDays.add("Sunday");
              } else {
                repeatDays.remove("Sunday");
              }
            },
          ),
          // Add more days as needed
          ElevatedButton(
            onPressed: () {
              onDaysSelected(repeatDays);
              Navigator.pop(context); // Go back after selecting days
            },
            child: Text("Save Repeat Days"),
          ),
        ],
      ),
    );
  }
}

// Main application class with BottomNavigationBar
class TaskManagementApp extends StatefulWidget {
  @override
  _TaskManagementAppState createState() => _TaskManagementAppState();
}

class _TaskManagementAppState extends State<TaskManagementApp> {
  List<Task> _todayTasks = [];
  List<Task> _completedTasks = [];
  List<Task> _repeatedTasks = [];
  int _currentIndex = 0;

  void _onCompleteTask(Task task) {
    setState(() {
      task.isCompleted = true;
      _completedTasks.add(task);
    });
  }

  void _onRepeatTask(Task task) {
    setState(() {
      _repeatedTasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task Management App'),
        ),
        body: _currentIndex == 0
            ? TodayTaskPage(onCompleteTask: _onCompleteTask, onRepeatTask: _onRepeatTask)
            : _currentIndex == 1
            ? CompletedTaskPage(completedTasks: _completedTasks)
            : RepeatedTaskPage(repeatedTasks: _repeatedTasks),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.today), label: "Today"),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: "Completed"),
            BottomNavigationBarItem(icon: Icon(Icons.repeat), label: "Repeated"),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(TaskManagementApp());
}
