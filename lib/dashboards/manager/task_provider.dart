import 'package:flutter/material.dart';

class DetailedTask {
  final String title;
  final String description;
  final String priority;
  final String status;
  final String assignee;
  final String dueDate;
  final String assigneeAvatarUrl;

  DetailedTask({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.assignee,
    required this.dueDate,
    required this.assigneeAvatarUrl,
  });
}

class TaskProvider with ChangeNotifier {
  String managerName = "Manager"; // for manager name

  final List<DetailedTask> _tasks = [
    // Example tasks
    DetailedTask(
      title: "Database Update",
      description: "Update the database schema",
      priority: "High",
      status: "To Do",
      assignee: "Ali khan",
      dueDate: "October 5",
      assigneeAvatarUrl: "https://via.placeholder.com/150",
    ),
    DetailedTask(
      title: "Backend Refactoring",
      description: "Refactor backend code",
      priority: "Medium",
      status: "Done",
      dueDate: "October 10",
      assigneeAvatarUrl: "https://via.placeholder.com/150",
      assignee: 'Ali Khan',
    ),
  ];

  List<DetailedTask> get tasks => _tasks;

  List<DetailedTask> getTasksByStatus(String status) {
    return _tasks.where((task) => task.status == status).toList();
  }

  int getCompletedTasksCount() {
    return _tasks.where((task) => task.status == "Done").length;
  }

  int getOverdueTasksCount() {
    // Example logic: Assume tasks with "To Do" status are overdue
    return _tasks.where((task) => task.status == "To Do").length;
  }

  double getCompletionRate() {
    if (_tasks.isEmpty) return 0.0;
    final completedTasks = getCompletedTasksCount();
    return completedTasks / _tasks.length;
  }

  void addTask(DetailedTask task) {
    _tasks.add(task);
    notifyListeners();
  }
}
