import 'package:flutter/material.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';
import 'package:board_widget/data/repository/app_settings_repository.dart';

class AppSettingsViewModel extends ChangeNotifier {
  late final AppSettingsRepository _appSettingsRepository;

  final AppSettings _appSettings = AppSettings(
      isDarkModeEnabled: false,
      backgroundColor: Colors.white,
      fontFamily: "KyoboHandwriting",
      fontSize: 1.0,
      dateFormat: "");

  AppSettingsViewModel() {
    _appSettingsRepository = AppSettingsRepository();
    getAllSettingsData();
  }

  List<Map<String, dynamic>> fontList = [
    {
      'title': "교보손글씨 2019",
      'fontFamily': "KyoboHandwriting",
    },
    {
      'title': "삼립호빵체 Outline",
      'fontFamily': "Samliphopangche",
    },
    {
      'title': "Noto Sans KR",
      'fontFamily': "NotoSansKR",
    },
    {
      'title': "어비 뒤죽박죽체",
      'fontFamily': "UhBee_GEN_WOO_Bold",
    },
    {
      'title': "어비 라미체",
      'fontFamily': "UhBee_Rami",
    },
    {
      'title': "손편지체",
      'fontFamily': "naver_handwriting",
    },
    {
      'title': "고딕 아니고 고딩",
      'fontFamily': "naver_goding_not_godic",
    },
    {
      'title': "코트라 희망체",
      'fontFamily': "KOTRA_HOPE",
    },
    {
      'title': "태백 은하수체",
      'fontFamily': "TAEBAEK_milkyway",
    },
  ];

  // 앱 세팅 값을 받아와서 해당 변수에 저장합니다
  Future<void> getAllSettingsData() async {
    _appSettings.isDarkModeEnabled =
        await _appSettingsRepository.getIsDarkModeEnabled();
    _appSettings.backgroundColor =
        await _appSettingsRepository.getBackgroundColor();
    _appSettings.fontFamily = await _appSettingsRepository.getFontFamily();
    _appSettings.fontSize = await _appSettingsRepository.getFontSize();
    _appSettings.dateFormat = await _appSettingsRepository.getDateFormat();
  }

  bool get isDarkModeEnabled => _appSettings.isDarkModeEnabled;
  Color get backgroundColor => _appSettings.backgroundColor;
  String get fontFamily => _appSettings.fontFamily;
  double get fontSize => _appSettings.fontSize;
  String get dateFormat => _appSettings.dateFormat;

  void setDarkModeEnabled(bool value) {
    _appSettingsRepository.updateIsDarkModeEnabled(value);
    _appSettings.isDarkModeEnabled = value;
    notifyListeners();
  }

  void selectBackground(Color value) {
    _appSettingsRepository.updateBackgroundColor(value);
    _appSettings.backgroundColor = value;
    notifyListeners();
  }

  void selectFont(BuildContext context, String value) {
    _appSettingsRepository.updateFontFamily(value);
    _appSettings.fontFamily = value;
    notifyListeners();
  }

  void selectFontSize(double value) {
    _appSettingsRepository.updateFontSize(value);
    _appSettings.fontSize = value;
    notifyListeners();
  }

  void selectDateFormat(String value) {
    _appSettingsRepository.updateDateFormat(value);
    _appSettings.dateFormat = value;
    notifyListeners();
  }
}
