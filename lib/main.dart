import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/Spalsh/splash_screen.dart';
import 'package:trackit/auth/first_page.dart';
import 'package:trackit/auth/login_page.dart';
import 'package:trackit/dashboards/admin/admin_dashboard.dart';
import 'package:trackit/dashboards/admin/dashboard_provider.dart';
import 'package:trackit/dashboards/admin/permission.dart';
import 'package:trackit/dashboards/admin/records.dart';
import 'package:trackit/dashboards/manager/task_core.dart';
import 'package:trackit/dashboards/manager/task_provider.dart';
import 'package:trackit/dashboards/manager/workerspay.dart';
import 'package:trackit/dashboards/worker/my_attendance.dart';
import 'package:trackit/dashboards/worker/payroll.dart';
import 'package:trackit/dashboards/worker/worker_portal.dart';
import 'package:trackit/dashboards/worker/worker_provider.dart';
import 'package:trackit/providers/RegisterProvider.dart';
import 'package:trackit/providers/auth_provider.dart';
import 'package:trackit/shared/chats/chatprovider.dart';
import 'package:trackit/shared/chats/chats.dart';
import 'package:trackit/shared/chats/chatscreen.dart';

import 'package:trackit/shared/settings_page.dart';
import 'package:trackit/shared/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    final lightTheme = ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );

    final darkTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
      ),
      dividerColor: Colors.grey,
      iconTheme: const IconThemeData(color: Colors.white),
    );

    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/home': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/splash': (context) => SplashView(),
        '/admin': (context) => AdminDashboard(),
        '/manager': (context) => TaskCore(),
        '/worker': (context) => WorkerPortal(),
        '/settings': (context) => SettingsPage(),
        '/permission': (context) => PermissionPage(),
        '/myattendance': (context) => MyAttendance(),
        '/payroll': (context) => MyPayroll(),
        '/chats': (context) => MyChat(),
        '/chatscreen': (context) => Chatscreen(),
        '/records': (context) => MyRecords(),
        '/workerspay': (context) => MyWorkerPay(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Trackit',
      theme: settingsProvider.isDarkMode ? darkTheme : lightTheme,
    );
  }
}
