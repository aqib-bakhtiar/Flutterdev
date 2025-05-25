import 'package:flutter/material.dart';
import 'package:trackit/dashboards/worker/worker_provider.dart';
import 'package:intl/intl.dart';

class TasksDoneLastMonth extends StatelessWidget {
  final WorkerProvider workerProvider;

  const TasksDoneLastMonth({super.key, required this.workerProvider});

  List<WorkerTask> getTasksDoneLastMonth() {
    final now = DateTime.now();
    final lastMonthStart = DateTime(now.year, now.month - 1, 1);
    final lastMonthEnd = DateTime(
      now.year,
      now.month,
      1,
    ).subtract(const Duration(days: 1));

    final dateFormat = DateFormat("MMM d"); // Format for "Sep 20"

    return workerProvider.tasksDone.where((task) {
      try {
        final taskDate = dateFormat.parse(
          task.dueDate,
        ); // Parse the custom date format
        final taskDateWithYear = DateTime(
          now.year,
          taskDate.month,
          taskDate.day,
        ); // Add the current year
        return taskDateWithYear.isAfter(lastMonthStart) &&
            taskDateWithYear.isBefore(lastMonthEnd);
      } catch (e) {
        print("Error parsing date: ${task.dueDate}");
        return false; // Skip invalid dates
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tasksDoneLastMonth = getTasksDoneLastMonth();
    final totalTasks = workerProvider.tasksDone.length;
    final completionRate =
        totalTasks > 0 ? tasksDoneLastMonth.length / totalTasks : 0.0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tasks Done Last Month",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Completed Last Month"),
                  const SizedBox(height: 8),
                  Text(
                    "${tasksDoneLastMonth.length}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Tasks"),
                  const SizedBox(height: 8),
                  Text(
                    "$totalTasks",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: completionRate,
            backgroundColor: Colors.grey[300],
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          const Text(
            "Task Details",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...tasksDoneLastMonth.map((task) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(task.title, style: const TextStyle(fontSize: 14)),
                  Text(
                    task.dueDate,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
