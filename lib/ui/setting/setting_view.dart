import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('General'),
            tiles: [
              SettingsTile(
                title: Text('Language'),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  // Handle language settings
                },
              ),
              SettingsTile(
                title: Text('Notifications'),
                leading: Icon(Icons.notifications),
                onPressed: (BuildContext context) {
                  // Handle notification settings
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Appearance'),
            tiles: [
              SettingsTile.switchTile(
                title: Text('Dark Mode'),
                leading: Icon(Icons.lightbulb_outline),
                initialValue: false,
                onToggle: (bool value) {
                  // Handle dark mode setting
                },
              ),
              SettingsTile(
                title: Text('Font Size'),
                leading: Icon(Icons.text_fields),
                onPressed: (BuildContext context) {
                  // Handle font size settings
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
