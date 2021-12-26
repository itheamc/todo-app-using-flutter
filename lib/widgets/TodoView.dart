import 'package:flutter/material.dart';
import 'package:todo_app_flutter/sqlitedb/todo.dart';
import 'package:todo_app_flutter/sqlitedb/todo_database.dart';
import 'package:todo_app_flutter/utils/TimeUtils.dart';

class TodoView extends StatefulWidget {
  final Todo todo;
  final TodoDatabase? todoDatabase;

  const TodoView({Key? key, required this.todo, required this.todoDatabase})
      : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  bool? checked;

  // Function to handle the checkbox
  void _handleChecked(bool? value) {
    setState(() {
      checked = value ?? false;
    });
    if (value != null && value == true) {
      widget.todoDatabase?.update(widget.todo.copy(
          completed: true, compTime: DateTime.now().millisecondsSinceEpoch));
    } else {
      widget.todoDatabase
          ?.update(widget.todo.copy(completed: false, compTime: -1));
    }
  }

  @override
  Widget build(BuildContext context) {
    var addedDuration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(widget.todo.time));
    var completedDuration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(widget.todo.compTime));

    return ListTile(
      title: Text(widget.todo.title,
          style: TextStyle(
              decoration: (checked ?? widget.todo.completed)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.todo.desc,
              style: TextStyle(
                  decoration: (checked ?? widget.todo.completed)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none)),
          Text(
              widget.todo.completed
                  ? "Completed ${fromDuration(completedDuration)}"
                  : "Added ${fromDuration(addedDuration)}",
              style: const TextStyle(
                  fontSize: 8,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: Checkbox(
          value: (checked ?? widget.todo.completed), onChanged: _handleChecked),
    );
  }
}
