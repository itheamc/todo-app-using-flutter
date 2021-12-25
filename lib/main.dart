import 'package:flutter/material.dart';
import 'package:todo_app_flutter/pages/HomePage.dart';


void main() {
  runApp(const TodoApp());
}

// _Todo App Widget
class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }

}



