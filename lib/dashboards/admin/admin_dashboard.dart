import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/dashboards/admin/dashboard_provider.dart';
import 'package:trackit/dashboards/worker/account_circle_dialog.dart';
import 'package:trackit/dashboards/worker/notification_dialog.dart';
import 'package:trackit/shared/announcements_page.dart';
import 'package:trackit/widgets/kpi_graph.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome, ${dashboardProvider.adminName}!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),

              child: Center(
                child: Text(
                  'Admin Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              leading: const Icon(Icons.dashboard),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
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
              title: const Text('Records'),
              leading: const Icon(Icons.record_voice_over),
              onTap: () {
                Navigator.pushNamed(context, '/records');
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
              title: const Text('Permissions'),
              leading: const Icon(Icons.approval),
              onTap: () {
                Navigator.pushNamed(context, '/permission');
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
            const SizedBox(height: 20),

            // Metrics Section
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricCard(
                      "${dashboardProvider.activeEmployees}",
                      "Active Employees",
                    ),
                    const Expanded(child: KpiGraph()), //  KPI graph
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetricCard(
                      "\$${dashboardProvider.totalPayroll}",
                      "Total Payroll",
                    ),
                    _buildMetricCard(
                      "${dashboardProvider.productivityRate}%",
                      "Productivity Rate",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Employee Directory Section
            const Text(
              "Employee Directory",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildEmployeeTable(dashboardProvider.employeeDirectory),
          ],
        ),
      ),
    );
  }

  // Helper method to build metric cards
  Widget _buildMetricCard(String value, String label) {
    return Expanded(
      child: SizedBox(
        height: 130,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(label, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build employee table
  Widget _buildEmployeeTable(List<Map<String, String>> employees) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow("Name", "Role", "Availability", isHeader: true),
            ...employees.map((employee) {
              return _buildTableRow(
                employee["name"]!,
                employee["role"]!,
                employee["availability"]!,
              );
            }),
          ],
        ),
      ),
    );
  }

  // Helper method to build table rows
  TableRow _buildTableRow(
    String name,
    String role,
    String availability, {
    bool isHeader = false,
  }) {
    return TableRow(
      decoration:
          isHeader
              ? const BoxDecoration(color: Colors.grey)
              : const BoxDecoration(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            role,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            availability,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color:
                  isHeader
                      ? Colors.black
                      : (availability == "Unavailable"
                          ? Colors.red
                          : Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}
