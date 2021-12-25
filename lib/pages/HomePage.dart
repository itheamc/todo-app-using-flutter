import 'package:flutter/material.dart';
import 'package:todo_app_flutter/sqlitedb/todo.dart';
import 'package:todo_app_flutter/sqlitedb/todo_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoDatabase? _todoDatabase;

  @override
  Widget build(BuildContext context) {
    // Calling function to initialize database
    _initializeDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Todos"),
      ),
      body: _todoDatabase != null
          ? FutureBuilder(
        future: _todoDatabase?.allTodos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.requireData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.requireData[index].title),
                  subtitle: Text(snapshot.requireData[index].desc),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data"),
            );
          }
        },
      )
          : const Center(
        child: Text("Please wait.."),
      ),
      floatingActionButton: _todoDatabase != null
          ? FloatingActionButton(
        onPressed: () {
          _todoDatabase?.insert(Todo(
              title: "title from fab", desc: "desc from fab", time: DateTime
              .now()
              .millisecondsSinceEpoch));
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }

  // Function to handle database initialization
  void _initializeDatabase() {
    TodoDatabase.initialize().then((value) {
      setState(() {
        _todoDatabase = value;
      });
    });
  }
}
