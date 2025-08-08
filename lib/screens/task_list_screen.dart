import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(
      id: 'Order-1043',
      title: 'Arrange Pickup',
      subtitle: '',
      assignee: 'Sandhya',
      isHighPriority: true,
      startDate: DateTime.now().subtract(const Duration(hours: 10)),
      status: TaskStatus.started,
    ),
    Task(
      id: 'Entity-2559',
      title: 'Adhoc Task',
      subtitle: '',
      assignee: 'Arman',
      isHighPriority: false,
      startDate: DateTime.now().subtract(const Duration(hours: 16)),
      status: TaskStatus.started,
    ),
    Task(
      id: 'Order-1020',
      title: 'Collect Payment',
      subtitle: '',
      assignee: 'Sandhya',
      isHighPriority: true,
      startDate: DateTime.now().subtract(const Duration(hours: 17)),
      status: TaskStatus.started,
    ),
    Task(
      id: 'Order-194',
      title: 'Arrange Delivery',
      subtitle: '',
      assignee: 'Prashant',
      isHighPriority: false,
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      status: TaskStatus.completed,
    ),
    Task(
      id: 'Entity-2184',
      title: 'Share Company Profile',
      subtitle: '',
      assignee: 'Asif Khan K',
      isHighPriority: false,
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      status: TaskStatus.completed,
    ),
    Task(
      id: 'Entity-472',
      title: 'Add Followup',
      subtitle: '',
      assignee: 'Avik',
      isHighPriority: false,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      status: TaskStatus.completed,
    ),
    Task(
      id: 'Enquiry-3563',
      title: 'Convert Enquiry',
      subtitle: '',
      assignee: 'Prashant',
      isHighPriority: false,
      startDate: DateTime.now().add(const Duration(days: 2)),
      status: TaskStatus.notStarted,
    ),
    Task(
      id: 'Order-176',
      title: 'Arrange Pickup',
      subtitle: '',
      assignee: 'Prashant',
      isHighPriority: true,
      startDate: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.notStarted,
    ),
  ];

  void _startTask(Task task) {
    setState(() {
      task.status = TaskStatus.started;
    });
  }

  void _completeTask(Task task) {
    setState(() {
      task.status = TaskStatus.completed;
    });
  }

  void _editTaskDate(Task task) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) {
      setState(() {
        task.startDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskCard(
            task: task,
            onStart: () => _startTask(task),
            onComplete: () => _completeTask(task),
            onEditDate: () => _editTaskDate(task),
          );
        },
      ),
    );
  }
}
