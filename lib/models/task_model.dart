enum TaskStatus { notStarted, started, completed }

class Task {
  final String id;
  final String title;
  final String subtitle;
  final String assignee;
  final bool isHighPriority;
  DateTime startDate;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.assignee,
    required this.isHighPriority,
    required this.startDate,
    required this.status,
  });
}
