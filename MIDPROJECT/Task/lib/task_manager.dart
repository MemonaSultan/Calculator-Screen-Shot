import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'task_model.dart';


class TaskManager {
  final Database db;

  TaskManager(this.db);

  Future<void> addTask(Task task) async {
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int id) async {
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> markAsCompleted(int id) async {
    await db.update('tasks', {'isCompleted': 1}, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> getTasksByStatus(bool isCompleted, bool isRepeated) async {
    final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'isCompleted = ? AND isRepeated = ?', whereArgs: [isCompleted ? 1 : 0, isRepeated ? 1 : 0]);
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        dueDate: DateTime.parse(maps[i]['dueDate']),
        isCompleted: maps[i]['isCompleted'] == 1,
        isRepeated: maps[i]['isRepeated'] == 1,
      );
    });
  }
}
