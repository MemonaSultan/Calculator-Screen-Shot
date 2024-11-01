import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

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
    const taskTable = '''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        time TEXT NOT NULL,
        repeatDays TEXT,
        alertMode TEXT,
        label TEXT
      )
    ''';
    await db.execute(taskTable);
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    final db = await instance.database;
    await db.insert('tasks', task);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await instance.database;
    return await db.query('tasks');
  }
}
