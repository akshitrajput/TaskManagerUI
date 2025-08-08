import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/date_utils.dart';
import 'status_badge.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onStart;
  final VoidCallback onComplete;
  final VoidCallback onEditDate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStart,
    required this.onComplete,
    required this.onEditDate,
  });

  Color getStatusColor() {
    final status = calculateDueStatus(task.startDate, task.status);
    if (status.contains("Overdue")) return Colors.red;
    if (status.contains("Due")) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final statusText = calculateDueStatus(task.startDate, task.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.assignment, size: 28, color: Colors.indigo),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.id,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  Text(task.title),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(task.assignee),
                      if (task.isHighPriority)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "High Priority",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (task.status != TaskStatus.completed)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onEditDate,
                          child: Row(
                            children: [
                              Text("Start: ${formatDate(task.startDate)}"),
                              if (task.status == TaskStatus.notStarted)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.edit, size: 16),
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      "Completed: ${formatDate(task.startDate)}",
                      style: const TextStyle(color: Colors.green),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusBadge(label: statusText, color: getStatusColor()),
                const SizedBox(height: 6),
                if (task.status == TaskStatus.notStarted)
                  TextButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Start Task"),
                    onPressed: onStart,
                  )
                else if (task.status == TaskStatus.started)
                  TextButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text("Mark as Complete"),
                    onPressed: onComplete,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
