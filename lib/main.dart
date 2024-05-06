import 'package:flutter/material.dart';
//import 'package:login/screens/locations.dart';
import 'package:login/screens/todo_list.dart';
//import 'screens/todo_list.dart';
import 'widgets/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter-app-login',
        theme: ThemeData.dark(),
        routes: {
          '/': (context) => const Login(),
          '/login': (context) => const Login(),
          '/home': (context) => const TodoListPage(),
        });
  }
}
