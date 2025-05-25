import 'package:flutter/material.dart';
import 'package:trackit/dashboards/manager/task_provider.dart';
import 'package:provider/provider.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return FloatingActionButton(
      onPressed: () {
        _showAddTaskDialog(context, taskProvider);
      },
      child: const Icon(Icons.add),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskProvider taskProvider) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String priority = "High";
    String status = "To Do";
    String assignee = "Ali khan";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                DropdownButtonFormField<String>(
                  value: assignee,
                  items: const [
                    DropdownMenuItem(
                      value: "Ali khan",
                      child: Text("Ali khan"),
                    ),
                    DropdownMenuItem(value: "Daniyal", child: Text("Daniyal")),
                    DropdownMenuItem(value: "Sarah", child: Text("Sarah")),
                  ],
                  onChanged: (value) {
                    assignee = value!;
                  },
                  decoration: const InputDecoration(labelText: "Assignee"),
                ),
                DropdownButtonFormField<String>(
                  value: priority,
                  items: const [
                    DropdownMenuItem(value: "High", child: Text("High")),
                    DropdownMenuItem(value: "Medium", child: Text("Medium")),
                    DropdownMenuItem(value: "Low", child: Text("Low")),
                  ],
                  onChanged: (value) {
                    priority = value!;
                  },
                  decoration: const InputDecoration(labelText: "Priority"),
                ),
                DropdownButtonFormField<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: "To Do", child: Text("To Do")),
                    DropdownMenuItem(
                      value: "In Progress",
                      child: Text("In Progress"),
                    ),
                    DropdownMenuItem(value: "Done", child: Text("Done")),
                  ],
                  onChanged: (value) {
                    status = value!;
                  },
                  decoration: const InputDecoration(labelText: "Status"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                taskProvider.addTask(
                  DetailedTask(
                    title: titleController.text,
                    description: descriptionController.text,
                    priority: priority,
                    status: status,
                    dueDate: "May 10, 2025", // Example due date
                    assigneeAvatarUrl: "https://via.placeholder.com/150",
                    assignee: 'Ali khan', // Example assignee
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
