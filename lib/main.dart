import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskManager UI',
      theme: ThemeData(primarySwatch: Colors.grey, fontFamily: 'Poppins'),
      home: const TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
