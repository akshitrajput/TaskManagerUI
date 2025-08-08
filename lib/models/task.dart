import 'package:flutter/material.dart';

enum TaskStatus { notStarted, started, completed }

enum TaskPriority { high, normal }

class Task {
  final String id;
  final String title;
  final String description;
  final String assignee;
  TaskStatus status;
  DateTime startDate;
  final TaskPriority priority;
  final DateTime? completedDate;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.status,
    required this.startDate,
    this.priority = TaskPriority.normal,
    this.completedDate,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? assignee,
    TaskStatus? status,
    DateTime? startDate,
    TaskPriority? priority,
    DateTime? completedDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      priority: priority ?? this.priority,
      completedDate: completedDate ?? this.completedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignee': assignee,
      'status': status.toString(),
      'startDate': startDate.toIso8601String(),
      'priority': priority.toString(),
      'completedDate': completedDate?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignee: json['assignee'],
      status: TaskStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      startDate: DateTime.parse(json['startDate']),
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString() == json['priority'],
        orElse: () => TaskPriority.normal,
      ),
      completedDate:
          json['completedDate'] != null
              ? DateTime.parse(json['completedDate'])
              : null,
    );
  }

  String get statusText {
    switch (status) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.started:
        return 'Started';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get statusColor {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.grey;
      case TaskStatus.started:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
    }
  }

  String get overdueText {
    if (status == TaskStatus.completed) return '';

    final now = DateTime.now();
    final difference = now.difference(startDate);

    if (difference.isNegative) {
      final days = difference.inDays.abs();
      if (days == 0) {
        return 'Due Tomorrow';
      } else if (days == 1) {
        return 'Due in 2 days';
      }
      return 'Due in $days days';
    } else {
      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;

      if (days > 0) {
        return 'Overdue - ${days}d ${hours}h';
      } else if (hours > 0) {
        return 'Overdue - ${hours}h ${minutes}m';
      } else {
        return 'Overdue - ${minutes}m';
      }
    }
  }
}
