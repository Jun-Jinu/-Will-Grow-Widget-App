import 'package:flutter/material.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';
import 'package:board_widget/data/repository/app_settings_repository.dart';
import 'package:hive/hive.dart';

class AppSettingsViewModel extends ChangeNotifier {
  late final AppSettingsRepository _appSettingsRepository;

  AppSettingsViewModel() {
    _appSettingsRepository = AppSettingsRepository();
  }
  int _selectedBackgroundIndex = 0;
  int _selectedFontIndex = 0;
  int _selectedFontSizeIndex = 0;
  int _selectedDateFormatIndex = 0;

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

  Future<AppSettings> loadSettings() {
    var appSettingsBox = Hive.box<AppSettings>('appSettingsBox');

    print("AppSettingsViewModel");
    print(appSettingsBox.get(0)!);
    return _appSettingsRepository.loadSettings();
  }

  void setDarkModeEnabled(bool value) {
    _appSettingsRepository.updateIsDarkModeEnabled(value);
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
