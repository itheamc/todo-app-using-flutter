import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_flutter/sqlitedb/todo.dart';

class TodoDatabase {
  // Private const variables that can't be reassigned
  static const String _dbName = "todos_db.db";
  static const String _tableName = "todos";
  static const int _version = 1;
  static TodoDatabase? _todoDatabase;
  Database? _database;


  // Private Constructor
  TodoDatabase._();


  static Future<TodoDatabase> initialize() async {
    TodoDatabase todoDatabase = TodoDatabase._()
      .._database = await _createDatabase();
    return todoDatabase;
  }


  // Private static function to create and return the instance of sql database
  static Future<Database> _createDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
        version: _version, onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE todos (_id INTEGER PRIMARY KEY AUTOINCREMENT, _title TEXT, _desc TEXT, _completed INTEGER, _time INTEGER)');
        });
  }

  // Function to get all todos
  Future<List<Todo>> allTodos() async {
    List<Map<String, dynamic>>? maps = await _database?.query(_tableName);
    return maps != null && maps.isNotEmpty ? Todo.fromMaps(maps) : List.empty();
  }

  // Function to get completed todos
  Future<List<Todo>> completedTodos() async {
    List<Map<String, dynamic>>? maps = await _database?.query(_tableName,
        columns: ['_id', '_title', '_desc', '_completed', '_time'],
        where: '_completed = ?',
        whereArgs: [1]); // 0 -> false, 1 -> true

    return maps != null && maps.isNotEmpty ? Todo.fromMaps(maps) : List.empty();
  }

  // Function to insert _todo
  Future<bool> insert(Todo todo) async {
    int? res = await _database?.insert(
      _tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res != null;
  }

  // Function to delete given _todo
  Future<bool> delete(Todo todo) async {
    int? res = await _database
        ?.delete(_tableName, where: '_id = ?', whereArgs: [todo.id]);
    return res != null;
  }

  // Function to update _todo
  Future<bool> update(Todo todo) async {
    int? res = await _database?.update(_tableName, todo.toMap(),
        where: '_id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res != null;
  }
}
