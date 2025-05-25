import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trackit/shared/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text(
              "Dark Mode",
              style: theme.textTheme.bodyMedium, // Use theme's text style
            ),
            value: settingsProvider.isDarkMode,
            onChanged: (value) {
              settingsProvider.toggleDarkMode(value);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Account Settings",
              style: theme.textTheme.bodyMedium, // Use theme's text style
            ),
            leading: Icon(
              Icons.account_circle,
              color: theme.iconTheme.color,
            ), // Use theme's icon color
            onTap: () {
              // Navigate to account settings page
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Notifications",
              style: theme.textTheme.bodyMedium, // Use theme's text style
            ),
            leading: Icon(
              Icons.notifications,
              color: theme.iconTheme.color,
            ), // Use theme's icon color
            onTap: () {
              // Navigate to notifications settings page
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Privacy Policy",
              style: theme.textTheme.bodyMedium, // Use theme's text style
            ),
            leading: Icon(
              Icons.privacy_tip,
              color: theme.iconTheme.color,
            ), // Use theme's icon color
            onTap: () {
              // Navigate to privacy policy page
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "About",
              style: theme.textTheme.bodyMedium, // Use theme's text style
            ),
            leading: Icon(
              Icons.info,
              color: theme.iconTheme.color,
            ), // Use theme's icon color
            onTap: () {
              // Navigate to about page
            },
          ),
        ],
      ),
    );
  }
}
