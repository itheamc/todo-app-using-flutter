import 'package:flutter/material.dart';
import 'package:todo_app_flutter/sqlitedb/todo.dart';
import 'package:todo_app_flutter/sqlitedb/todo_database.dart';
import 'package:todo_app_flutter/widgets/TodoView.dart';

class HomePage extends StatefulWidget {
  final TodoDatabase? todoDatabase;
  const HomePage({Key? key, required this.todoDatabase}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Todos"),
      ),
      body: widget.todoDatabase != null
          ? FutureBuilder(
        future: widget.todoDatabase?.todos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.requireData.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoView(todo: snapshot.requireData[snapshot.requireData.length - index - 1], todoDatabase: widget.todoDatabase);
              },
            );
          } else {
            return const Center(
              child: Text("No Todos"),
            );
          }
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: widget.todoDatabase != null
          ? FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/newtodo");
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}
