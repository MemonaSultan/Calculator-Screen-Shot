import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Task {
  final int? id;
  final String name;
  final String time;
  final String label;

  Task({this.id, required this.name, required this.time, required this.label});

  // Convert Task object to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'label': label,
    };
  }

  // Convert Map from database to Task object
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      label: map['label'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        time TEXT NOT NULL,
        label TEXT
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> fetchAllTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
