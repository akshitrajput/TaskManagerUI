import 'package:intl/intl.dart';
import '../models/task_model.dart';

String formatDate(DateTime date) {
  return DateFormat('MMM dd').format(date);
}

String calculateDueStatus(DateTime startDate, TaskStatus status) {
  if (status == TaskStatus.completed) {
    return 'Completed: ${formatDate(startDate)}';
  }

  final now = DateTime.now();
  final difference = startDate.difference(now);

  if (difference.inDays == 0) {
    return "Due Tomorrow";
  } else if (difference.isNegative) {
    final hours = difference.inHours.abs();
    final minutes = difference.inMinutes.abs() % 60;
    return "Overdue - ${hours}h ${minutes}m";
  } else {
    return "Due in ${difference.inDays} days";
  }
}
