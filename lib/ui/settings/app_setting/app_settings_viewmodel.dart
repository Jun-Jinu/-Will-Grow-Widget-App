import 'package:flutter/material.dart';

class AppSettingsViewModel extends ChangeNotifier {
  bool _isDarkModeEnabled = true;
  int _selectedBackgroundIndex = 0;
  int _selectedFontIndex = 0;
  int _selectedFontSizeIndex = 0;
  int _selectedDateFormatIndex = 0;

  bool get isDarkModeEnabled => _isDarkModeEnabled;
  int get selectedBackgroundIndex => _selectedBackgroundIndex;
  int get selectedFontIndex => _selectedFontIndex;
  int get selectedFontSizeIndex => _selectedFontSizeIndex;
  int get selectedDateFormatIndex => _selectedDateFormatIndex;

  List<String> get backgroundColors => [
        '배경색1',
        '배경색2',
        '배경색3',
      ];

  List<String> get fonts => [
        '폰트1',
        '폰트2',
      ];

  List<String> get fontSizes => [
        '크게',
        '보통',
        '작게',
      ];

  List<String> get dateFormats => [
        '방법1',
        '방법2',
      ];

  void setDarkModeEnabled(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }

  void selectBackground(int index) {
    _selectedBackgroundIndex = index;
    notifyListeners();
  }

  void selectFont(int index) {
    _selectedFontIndex = index;
    notifyListeners();
  }

  void selectFontSize(int index) {
    _selectedFontSizeIndex = index;
    notifyListeners();
  }

  void selectDateFormat(int index) {
    _selectedDateFormatIndex = index;
    notifyListeners();
  }
}
