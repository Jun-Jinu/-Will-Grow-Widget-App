import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 2)
class AppSettings {
  AppSettings({
    required this.isDarkModeEnabled,
    required this.primaryColor,
    required this.fontFamily,
    required this.fontSize,
    required this.dateFormat,
  });

  @HiveField(0)
  bool isDarkModeEnabled;

  @HiveField(1)
  Color primaryColor;

  @HiveField(2)
  String fontFamily;

  @HiveField(3)
  double fontSize;

  @HiveField(4)
  String dateFormat;

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isDarkModeEnabled: json['isDarkModeEnabled'],
      primaryColor: Color(json['primaryColor']),
      fontFamily: json['fontFamily'],
      fontSize: json['fontSize'],
      dateFormat: json['dateFormat'],
    );
  }
}

// flutter packages pub run build_runner build
// 로 해당 모델의 g.dart파일 생성