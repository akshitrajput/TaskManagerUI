import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../services/storage_service.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await StorageService.loadTasks();
    setState(() {
      tasks = loadedTasks;
      isLoading = false;
    });
  }

  Future<void> _saveTasks() async {
    await StorageService.saveTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskCard(
            task: task,
            onStartTask:
                task.status == TaskStatus.notStarted
                    ? () => _startTask(index)
                    : null,
            onMarkComplete:
                task.status == TaskStatus.started
                    ? () => _markTaskComplete(index)
                    : null,
            onDateChanged:
                (task.status == TaskStatus.notStarted ||
                        task.status == TaskStatus.started)
                    ? (newDate) => _updateTaskDate(index, newDate)
                    : null,
          );
        },
      ),
    );
  }

  void _startTask(int index) {
    setState(() {
      tasks[index] = tasks[index].copyWith(status: TaskStatus.started);
    });
    _saveTasks();
  }

  void _markTaskComplete(int index) {
    setState(() {
      tasks[index] = tasks[index].copyWith(
        status: TaskStatus.completed,
        completedDate: DateTime.now(),
      );
    });
    _saveTasks();
  }

  void _updateTaskDate(int index, DateTime newDate) {
    setState(() {
      tasks[index] = tasks[index].copyWith(startDate: newDate);
    });
    _saveTasks();
  }
}
