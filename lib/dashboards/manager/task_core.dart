import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/dashboards/manager/task_provider.dart';
import 'package:trackit/dashboards/manager/floating_action_button.dart';
import 'package:trackit/dashboards/worker/account_circle_dialog.dart';
import 'package:trackit/dashboards/worker/notification_dialog.dart';
import 'package:trackit/shared/announcements_page.dart';

class TaskCore extends StatefulWidget {
  const TaskCore({super.key});

  @override
  _TaskCoreState createState() => _TaskCoreState();
}

class _TaskCoreState extends State<TaskCore>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3, // 3 tabs: To Do, In Progress, Done
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome, ${taskProvider.managerName}!",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_add, size: 35),
            onPressed: () {
              NotificationDialog.show(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, size: 35),
            onPressed: () {
              AccountCircleDialog.show(context);
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTaskList(taskProvider.getTasksByStatus("To Do")),
                _buildTaskList(taskProvider.getTasksByStatus("In Progress")),
                _buildTaskList(taskProvider.getTasksByStatus("Done")),
              ],
            ),
          ),
          _buildTaskOverview(context, taskProvider),
        ],
      ),
      floatingActionButton:
          const CustomFloatingActionButton(), // Use the custom FAB
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Center(
              child: Text(
                'Manager Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            title: const Text('Dashboard'),
            leading: const Icon(Icons.dashboard),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/manager');
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
            title: const Text('Attendance'),
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
            title: const Text('Workers Payroll'),
            leading: const Icon(Icons.payments),
            onTap: () {
              Navigator.pushNamed(context, '/workerspay');
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
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.white,

        unselectedLabelColor: Theme.of(context).primaryColor,
        indicator: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        tabs: const [
          Tab(text: "To Do"),
          Tab(text: "In Progress"),
          Tab(text: "Done"),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<DetailedTask> tasks) {
    if (tasks.isEmpty) {
      return const Center(child: Text("No tasks available."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text("Due ${task.dueDate}"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.priority,
                  style: TextStyle(color: _getPriorityColor(task.priority)),
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(task.assigneeAvatarUrl),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskOverview(BuildContext context, TaskProvider taskProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
              "Task Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Completed"),
                    const SizedBox(height: 8),
                    Text(
                      "${taskProvider.getCompletedTasksCount()}",
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
                    const Text("Overdue"),
                    const SizedBox(height: 8),
                    Text(
                      "${taskProvider.getOverdueTasksCount()}",
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
              value: taskProvider.getCompletionRate(),
              backgroundColor: Colors.grey[300],
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}
