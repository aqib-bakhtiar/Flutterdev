import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/dashboards/worker/account_circle_dialog.dart';
import 'package:trackit/dashboards/worker/notification_dialog.dart';
import 'package:trackit/dashboards/worker/task_submission.dart';
import 'package:trackit/dashboards/worker/tasks_done_last_month.dart';

import 'package:trackit/dashboards/worker/worker_provider.dart';
import 'package:trackit/shared/announcements_page.dart';

class WorkerPortal extends StatelessWidget {
  const WorkerPortal({super.key});

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome, ${workerProvider.workerName}!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_add, size: 35),
            onPressed: () {
              NotificationDialog.show(context); // Call the notification dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, size: 35),
            onPressed: () {
              AccountCircleDialog.show(
                context,
              ); // Call the account circle dialog
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),

              child: Center(
                child: Text(
                  'Worker Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              leading: const Icon(Icons.dashboard),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/worker');
              },
            ),
            ListTile(
              title: const Text('Announcements'),
              leading: const Icon(Icons.announcement),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnnouncementsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('My Attendance'),
              leading: const Icon(Icons.calendar_today),

              onTap: () {
                Navigator.pushNamed(context, '/myattendance');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: const Text('Payroll'),
              leading: const Icon(Icons.monetization_on),

              onTap: () {
                Navigator.pushNamed(context, '/payroll');
              },
            ),

            ListTile(
              title: const Text('Chats'),
              leading: const Icon(Icons.chat),

              onTap: () {
                Navigator.pushNamed(context, '/chatscreen');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                //
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...workerProvider.tasks.map((task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildTaskCard(context, task.title, task.dueDate),
              );
            }),
            const SizedBox(height: 25),
            const Text(
              "Check IN and OUT",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Check In logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Checked In!')),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                          child: const Icon(
                            Icons.login,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Check In'),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Check Out logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Checked Out!')),
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          child: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Check Out'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TasksDoneLastMonth(
              workerProvider: workerProvider,
            ), //  <<<<< last month work >>>>>>
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, String title, String dueDate) {
    return GestureDetector(
      onTap: () {
        // Navigate to the task submission screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskSubmissionScreen(taskTitle: title),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dueDate,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
