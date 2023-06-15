import 'package:flutter/material.dart';
import '../model/theme/app/app_settings.dart';
import '../datasource/local_datasource.dart';

class AppSettingsRepository {
  late final LocalDataSource _localDataSource;

  AppSettingsRepository() {
    _localDataSource = LocalDataSource();
  }

  Future<AppSettings> loadSettings() {
    return _localDataSource.getAppSettings();
  }

  Future<bool> getIsDarkModeEnabled() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.isDarkModeEnabled;
  }

  Future<Color> getPrimaryColor() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.primaryColor;
  }

  Future<Color> getSecondaryColor() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.secondaryColor;
  }

  Future<String> getFontFamily() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.fontFamily;
  }

  Future<double> getFontSize() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.fontSize;
  }

  Future<String> getDateFormat() async {
    AppSettings settings = await _localDataSource.getAppSettings();
    return settings.dateFormat;
  }

  /// 다크 모드 설정 업데이트
  Future<void> updateIsDarkModeEnabled(bool isDarkModeEnabled) {
    return _localDataSource.updateAppSettings(
        isDarkModeEnabled: isDarkModeEnabled);
  }

  /// 주요색 설정 업데이트
  Future<void> updatePrimaryColor(Color primaryColor) {
    return _localDataSource.updateAppSettings(primaryColor: primaryColor);
  }

  /// 보조색 설정 업데이트
  Future<void> updateSecondaryColor(Color secondaryColor) {
    return _localDataSource.updateAppSettings(secondaryColor: secondaryColor);
  }

  /// 폰트 패밀리 설정 업데이트
  Future<void> updateFontFamily(String fontFamily) {
    return _localDataSource.updateAppSettings(fontFamily: fontFamily);
  }

  /// 폰트 크기 설정 업데이트
  Future<void> updateFontSize(double fontSize) {
    return _localDataSource.updateAppSettings(fontSize: fontSize);
  }

  /// 날짜 표시 형식 설정 업데이트
  Future<void> updateDateFormat(String dateFormat) {
    return _localDataSource.updateAppSettings(dateFormat: dateFormat);
  }
}
