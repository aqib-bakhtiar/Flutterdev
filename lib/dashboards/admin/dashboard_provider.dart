import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  String adminName = "Admin"; // for admin name

  int activeEmployees = 0;
  double productivityRate = 0.0;
  double totalPayroll = 0.0;
  List<Map<String, String>> employeeDirectory = [];

  DashboardProvider() {
    fetchDashboardData();
  }

  void fetchDashboardData() {
    activeEmployees = 138;
    productivityRate = 64.0;
    totalPayroll = 32540.0;
    employeeDirectory = [
      {"name": "Talha", "role": "Manager", "availability": "Available"},
      {"name": "Ali Khan", "role": "Designer", "availability": "Unavailable"},
      {"name": "Sarah Ali", "role": "Developer", "availability": "Available"},
      {"name": "Daniyal ", "role": "Analyst", "availability": "Available"},
      {"name": "Ahmad Jan ", "role": "Worker", "availability": "Unavailable"},
    ];
    notifyListeners();
  }
}
