import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String _tasksKey = 'tasks_data';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setString(_tasksKey, jsonEncode(tasksJson));
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);

    if (tasksString == null) {
      return _getDefaultTasks();
    }

    try {
      final List<dynamic> tasksJson = jsonDecode(tasksString);
      return tasksJson.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      return _getDefaultTasks();
    }
  }

  static List<Task> _getDefaultTasks() {
    return [
      Task(
        id: 'Order-1043',
        title: 'Arrange Pickup',
        description: 'Arrange pickup for customer order',
        assignee: 'Sandhya',
        status: TaskStatus.started,
        startDate: DateTime(2025, 8, 1),
        priority: TaskPriority.high,
      ),
      Task(
        id: 'Entity-2559',
        title: 'Adhoc Task',
        description: 'Complete adhoc task assignment',
        assignee: 'Arman',
        status: TaskStatus.started,
        startDate: DateTime(2025, 7, 28),
      ),
      Task(
        id: 'Order-1020',
        title: 'Collect Payment',
        description: 'Collect pending payment from customer',
        assignee: 'Sandhya',
        status: TaskStatus.started,
        startDate: DateTime(2025, 8, 4),
        priority: TaskPriority.high,
      ),
      Task(
        id: 'Order-194',
        title: 'Arrange Delivery',
        description: 'Arrange delivery for completed order',
        assignee: 'Prashant',
        status: TaskStatus.completed,
        startDate: DateTime(2025, 8, 2),
        completedDate: DateTime(2025, 8, 8),
      ),
      Task(
        id: 'Entity-2184',
        title: 'Share Company Profile',
        description: 'Share company profile with client',
        assignee: 'Asif Khan K',
        status: TaskStatus.completed,
        startDate: DateTime(2025, 7, 25),
        completedDate: DateTime(2025, 8, 7),
      ),
      Task(
        id: 'Entity-472',
        title: 'Add Followup',
        description: 'Add followup notes for client meeting',
        assignee: 'Avik',
        status: TaskStatus.completed,
        startDate: DateTime(2025, 7, 12),
        completedDate: DateTime(2025, 7, 15),
      ),
      Task(
        id: 'Enquiry-3563',
        title: 'Convert Enquiry',
        description: 'Convert lead enquiry to sale',
        assignee: 'Prashant',
        status: TaskStatus.notStarted,
        startDate: DateTime(2025, 8, 12),
      ),
      Task(
        id: 'Order-176',
        title: 'Arrange Pickup',
        description: 'Arrange pickup for new order',
        assignee: 'Prashant',
        status: TaskStatus.notStarted,
        startDate: DateTime(2025, 8, 7),
        priority: TaskPriority.high,
      ),
    ];
  }
}
