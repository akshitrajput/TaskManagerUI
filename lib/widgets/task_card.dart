import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';
import 'task_details_popup.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onStartTask;
  final VoidCallback? onMarkComplete;
  final Function(DateTime)? onDateChanged;

  const TaskCard({
    Key? key,
    required this.task,
    this.onStartTask,
    this.onMarkComplete,
    this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTaskDetails(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left status indicator line
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: task.statusColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              // Main content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row with title and status
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      task.id,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            task.status == TaskStatus.completed
                                                ? Colors.grey
                                                : Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.more_vert,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        task.status == TaskStatus.completed
                                            ? Colors.grey
                                            : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      task.assignee,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    if (task.priority == TaskPriority.high) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: const Text(
                                          'High Priority',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Right side status and date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (task.status != TaskStatus.completed &&
                                  task.overdueText.isNotEmpty)
                                Text(
                                  task.overdueText,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        task.overdueText.contains('Due')
                                            ? Colors.orange
                                            : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (task.status == TaskStatus.completed)
                                Text(
                                  'Completed: ${DateFormatter.formatDate(task.completedDate ?? DateTime.now())}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Start${task.status == TaskStatus.completed ? 'ed' : ''}: ${DateFormatter.formatDate(task.startDate)}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  if (task.status == TaskStatus.notStarted ||
                                      (task.status == TaskStatus.started &&
                                          onDateChanged != null)) ...[
                                    const SizedBox(width: 3),
                                    GestureDetector(
                                      onTap: () {
                                        _showDatePicker(context);
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        size: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (task.status == TaskStatus.notStarted &&
                              onStartTask != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.play_circle,
                                  size: 14,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 3),
                                GestureDetector(
                                  onTap: () {
                                    onStartTask!();
                                  },
                                  child: const Text(
                                    'Start Task',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (task.status == TaskStatus.started &&
                              onMarkComplete != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 3),
                                GestureDetector(
                                  onTap: () {
                                    onMarkComplete!();
                                  },
                                  child: const Text(
                                    'Mark as complete',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => TaskDetailPopup(
            task: task,
            onStartTask: onStartTask,
            onMarkComplete: onMarkComplete,
            onDateChanged: onDateChanged,
          ),
    );
  }

  void _showDatePicker(BuildContext context) {
    if (onDateChanged == null) return;

    showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        onDateChanged!(selectedDate);
      }
    });
  }
}
