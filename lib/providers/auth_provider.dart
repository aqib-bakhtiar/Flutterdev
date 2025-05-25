import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _role; //  'admin', 'manager', 'worker'
  bool _isLoggedIn = false;

  String? get role => _role;
  bool get isLoggedIn => _isLoggedIn;

  void login(String email, String password) {
    // will connect to backend
    if (email == 'admin.com') {
      _role = 'admin';
    } else if (email == 'manager.com') {
      _role = 'manager';
    } else {
      _role = 'worker';
    }

    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _role = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
