import 'package:flutter/material.dart';
import 'package:todo_app_flutter/pages/HomePage.dart';
import 'package:todo_app_flutter/pages/NewTodoPage.dart';
import 'package:todo_app_flutter/sqlitedb/todo_database.dart';


void main() {
  runApp(const TodoApp());
}

// _Todo App Widget
class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  TodoDatabase? _todoDatabase;

  @override
  void dispose() {
    _todoDatabase?.close();
    super.dispose();
  }

  // Function to handle database initialization
  void _initializeDatabase() {
    TodoDatabase.initialize().then((value) {
      setState(() {
        _todoDatabase = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calling function to initialize the database
    _initializeDatabase();

    return MaterialApp(
      title: "Todo App",
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(todoDatabase: _todoDatabase),
        '/newtodo': (context) => NewTodoPage(todoDatabase: _todoDatabase)
      },
      debugShowCheckedModeBanner: false,
    );
  }
}



