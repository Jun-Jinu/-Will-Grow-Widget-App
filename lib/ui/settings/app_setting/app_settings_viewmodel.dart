import 'package:flutter/material.dart';

class AppSettingsViewModel with ChangeNotifier {
  bool _darkMode = false;
  String _selectedLanguage = 'English';

  bool get darkMode => _darkMode;
  String get selectedLanguage => _selectedLanguage;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    // Perform any necessary operations related to toggling dark mode
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    // Perform any necessary operations related to setting the language
    notifyListeners();
  }
}
