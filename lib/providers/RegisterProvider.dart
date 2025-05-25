import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';
  String selectedRole = 'worker'; // Default role

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateRole(String? role) {
    if (role != null) {
      selectedRole = role;
      notifyListeners();
    }
  }

  void register() {
    // Simulated registration logic
    print('Registering user:');
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Password: $selectedRole');
  } //<<<<<<<<<<<<<prints the entered data>>>>>>>>>>>>>>>>
}
