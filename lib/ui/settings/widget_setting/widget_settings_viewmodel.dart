import 'package:flutter/material.dart';

class WidgetSettingsViewModel extends ChangeNotifier {
  //TODO: 다 정해지면 MODEL 만들기
  bool isTextChangeHourly = false;
  int isTextChangeHour = 24; // 위젯 텍스트 변환 주기
  Color _fontColor = Colors.white;
  Color _backgroundColor = Colors.blueAccent;
  String fontFamily = "";
  double _fontSize = 24.0;
  //날짜 표시, 날짜 형식도?

  Color get fontColor => _fontColor;
  Color get backgroundColor => _backgroundColor;
  double get fontSize => _fontSize;

  void toggleTextChangeHourly(bool value) {
    isTextChangeHourly = value;
    notifyListeners();
  }

  void onChangeTextChangeHour(int hour) {
    isTextChangeHour = hour;
    notifyListeners();
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setFontColor(Color color) {
    _fontColor = color;
    notifyListeners();
  }

  void setFontSize(double fontSize) {
    _fontSize = fontSize;
    notifyListeners();
  }
}
