import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:board_widget/data/model/theme/widget/widget_settings.dart';
import 'package:board_widget/data/repository/widget_settings_repository.dart';
import 'dart:convert';

class WidgetSettingsViewModel extends ChangeNotifier {
  late final WidgetSettingsRepository _widgetSettingsRepository;

  final WidgetSettings _widgetSettings = WidgetSettings(
    isTextChangeHourly: true,
    isTextChangeHour: 24,
    fontColor: 'black',
    backgroundColor: 'grey',
    fontFamily: "KyoboHandwriting2019",
    fontSize: 24.0,
  );

  WidgetSettingsViewModel() {
    _widgetSettingsRepository = WidgetSettingsRepository();
    getAllSettingsData();
  }

  // 앱 세팅 값을 받아와서 해당 변수에 저장합니다
  Future<void> getAllSettingsData() async {
    _widgetSettings.isTextChangeHourly =
        await _widgetSettingsRepository.getIsTextChangeHourly();
    _widgetSettings.isTextChangeHour =
        await _widgetSettingsRepository.getIsTextChangeHour();
    _widgetSettings.fontColor = await _widgetSettingsRepository.getFontColor();
    _widgetSettings.backgroundColor =
        await _widgetSettingsRepository.getBackgroundColor();
    _widgetSettings.fontFamily =
        await _widgetSettingsRepository.getFontFamily();
    _widgetSettings.fontSize = await _widgetSettingsRepository.getFontSize();
  }

  bool get isTextChangeHourly => _widgetSettings.isTextChangeHourly;
  int get isTextChangeHour => _widgetSettings.isTextChangeHour;
  String get fontColor => _widgetSettings.fontColor;
  String get backgroundColor => _widgetSettings.backgroundColor;
  String get fontFamily => _widgetSettings.fontFamily;
  double get fontSize => _widgetSettings.fontSize;

  void setIsTextChangeHourly(bool value) {
    _widgetSettingsRepository.updateIsTextChangeHourly(value);
    _widgetSettings.isTextChangeHourly = value;
    notifyListeners();
  }

  void setIsTextChangeHour(int value) {
    _widgetSettingsRepository.updateIsTextChangeHour(value);
    _widgetSettings.isTextChangeHour = value;
    notifyListeners();
  }

  void setFontColor(String value) {
    _widgetSettingsRepository.updateFontColor(value);
    _widgetSettings.fontColor = value;
    notifyListeners();
  }

  void setBackgroundColor(String value) {
    _widgetSettingsRepository.updateBackgroundColor(value);
    _widgetSettings.backgroundColor = value;
    notifyListeners();
  }

  void setFontFamily(String value) {
    // _widgetSettingsRepository.updateFontFamily(value);
    // _widgetSettings.fontFamily = value;

    WidgetKit.setItem(
        'widgetData',
        jsonEncode(WidgetSettings(
          isTextChangeHourly: true,
          isTextChangeHour: 24,
          fontColor: 'black',
          backgroundColor: 'grey',
          fontFamily: "KyoboHandwriting2019",
          fontSize: 24.0,
        )),
        'group.boardwidget');
    WidgetKit.reloadAllTimelines();

    notifyListeners();
  }

  void setFontSize(double value) {
    _widgetSettingsRepository.updateFontSize(value);
    _widgetSettings.fontSize = value;
    notifyListeners();
  }
}


// class WidgetData {
//   final String text;
//   WidgetData(this.text);

//   WidgetData.fromJson(Map<String, dynamic> json) : text = json['text'];
//   Map<String, dynamic> toJson() => {'text': text};

// }

// class WidgetData {
//   String text;
//   WidgetSettings settings;
//   WidgetData(this.text, this.settings);

//   WidgetData.fromJson(Map<String, dynamic> json)
//       : text = json['text'],
//         settings = WidgetSettings.fromJson(json['settings']);

//   Map<String, dynamic> toJson() => {
//         'text': text,
//         'settings': settings.toJson(),
//       };
// }
