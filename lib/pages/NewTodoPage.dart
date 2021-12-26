import 'package:flutter/material.dart';
import 'package:todo_app_flutter/sqlitedb/todo.dart';
import 'package:todo_app_flutter/sqlitedb/todo_database.dart';

class NewTodoPage extends StatefulWidget {
  final TodoDatabase? todoDatabase;

  const NewTodoPage({Key? key, this.todoDatabase}) : super(key: key);

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  String title = "";
  String desc = "";

  // Global Key for Form
  final _formKey = GlobalKey<FormState>();

  // Function to be called whenever save button is clicked
  void _onPressed() {
    if (_formKey.currentState!.validate()) {
      widget.todoDatabase?.insert(Todo(
          title: title,
          desc: desc,
          time: DateTime.now().millisecondsSinceEpoch));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved'), duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Todo"),
        actions: [
          IconButton(onPressed: _onPressed, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please give a title";
                  }
                  return null;
                },
                  decoration: const InputDecoration(
                      labelText: "Title")
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    desc = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please write a description..";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Description"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
