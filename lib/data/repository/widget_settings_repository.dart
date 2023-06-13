import 'package:flutter/material.dart';
import '../model/theme/widget/widget_settings.dart';
import '../datasource/local_datasource.dart';

class WidgetSettingsRepository {
  late final LocalDataSource _localDataSource;

  WidgetSettingsRepository() {
    _localDataSource = LocalDataSource();
  }

  // 로컬 데이터 소스에서 위젯 설정 가져오기
  Future<WidgetSettings> loadSettings() {
    return _localDataSource.getWidgetSettings();
  }

  // 아래는 get 함수들입니다.

  // 위젯 설정에서 텍스트 변경 주기를 시간 단위로 가져옵니다.
  Future<bool> getIsTextChangeHourly() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.isTextChangeHourly;
  }

  // 위젯 설정에서 텍스트 변경 주기의 시간 값을 가져옵니다.
  Future<int> getIsTextChangeHour() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.isTextChangeHour;
  }

  // 위젯 설정에서 폰트 색상을 가져옵니다.
  Future<String> getFontColor() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.fontColor;
  }

  // 위젯 설정에서 배경색을 가져옵니다.
  Future<String> getBackgroundColor() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.backgroundColor;
  }

  // 위젯 설정에서 폰트 패밀리를 가져옵니다.
  Future<String> getFontFamily() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.fontFamily;
  }

  // 위젯 설정에서 폰트 크기를 가져옵니다.
  Future<double> getFontSize() async {
    WidgetSettings settings = await _localDataSource.getWidgetSettings();
    return settings.fontSize;
  }

  // 아래는 update 함수들입니다.

  // 위젯 설정에서 텍스트 변경 주기를 업데이트합니다.
  Future<void> updateIsTextChangeHourly(bool isTextChangeHourly) {
    return _localDataSource.updateWidgetSettings(
        isTextChangeHourly: isTextChangeHourly);
  }

  // 위젯 설정에서 날짜 표시 형식을 업데이트합니다.
  Future<void> updateIsTextChangeHour(int isTextChangeHour) {
    return _localDataSource.updateWidgetSettings(
        isTextChangeHour: isTextChangeHour);
  }

  // 위젯 설정에서 폰트 색상을 업데이트합니다.
  Future<void> updateFontColor(String fontColor) {
    return _localDataSource.updateWidgetSettings(fontColor: fontColor);
  }

  // 위젯 설정에서 배경색을 업데이트합니다.
  Future<void> updateBackgroundColor(String backgroundColor) {
    return _localDataSource.updateWidgetSettings(
        backgroundColor: backgroundColor);
  }

  // 위젯 설정에서 폰트 패밀리를 업데이트합니다.
  Future<void> updateFontFamily(String fontFamily) {
    return _localDataSource.updateWidgetSettings(fontFamily: fontFamily);
  }

  // 위젯 설정에서 폰트 크기를 업데이트합니다.
  Future<void> updateFontSize(double fontSize) {
    return _localDataSource.updateWidgetSettings(fontSize: fontSize);
  }
}
