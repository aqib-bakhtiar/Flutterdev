import 'package:flutter/material.dart';

class WorkerTask {
  final String title;
  final String dueDate;

  WorkerTask({required this.title, required this.dueDate});
}

class WorkerProvider with ChangeNotifier {
  final List<WorkerTask> _tasksDone = [
    WorkerTask(title: "Database Update", dueDate: "Sep 20"),
    WorkerTask(title: "Backend Refactoring", dueDate: "Oct 15"),
    WorkerTask(title: "UI Improvements", dueDate: "Aug 25"),
  ];

  List<WorkerTask> get tasksDone => _tasksDone;
  String workerName = "Worker"; //  worker name

  final List<WorkerTask> _tasks = [
    WorkerTask(title: "Fix Login Bug", dueDate: "Sep 25"),
    WorkerTask(title: "Code Review", dueDate: "Sep 27"),
  ];

  List<WorkerTask> getTasksDoneLastMonth() {
    final now = DateTime.now();
    final lastMonthStart = DateTime(now.year, now.month - 1, 1);
    final lastMonthEnd = DateTime(
      now.year,
      now.month,
      1,
    ).subtract(const Duration(days: 1));

    return _tasksDone.where((task) {
      final taskDate = DateTime.parse(
        task.dueDate,
      ); // Ensure `dueDate` is in ISO format (e.g., "2025-05-01")
      return taskDate.isAfter(lastMonthStart) &&
          taskDate.isBefore(lastMonthEnd);
    }).toList();
  }

  List<WorkerTask> get tasks => _tasks;

  void addTask(WorkerTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void markTaskAsDone(WorkerTask task) {
    _tasks.remove(task);
    _tasksDone.add(task);
    notifyListeners();
  }
}
