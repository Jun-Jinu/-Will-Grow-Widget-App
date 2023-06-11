import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'widget_settings.g.dart';

@HiveType(typeId: 3)
class WidgetSettings {
  WidgetSettings({
    required this.isTextChangeHourly,
    required this.isTextChangeHour,
    required this.fontColor,
    required this.backgroundColor,
    required this.fontFamily,
    required this.fontSize,
  });

  @HiveField(0)
  bool isTextChangeHourly;

  @HiveField(1)
  int isTextChangeHour;

  @HiveField(2)
  Color fontColor;

  @HiveField(3)
  Color backgroundColor;

  @HiveField(4)
  String fontFamily;

  @HiveField(5)
  double fontSize;

  factory WidgetSettings.fromJson(Map<String, dynamic> json) {
    return WidgetSettings(
      isTextChangeHourly: json['isTextChangeHourly'],
      isTextChangeHour: json['isTextChangeHour'],
      fontColor: Color(json['fontColor']),
      backgroundColor: Color(json['backgroundColor']),
      fontFamily: json['fontFamily'],
      fontSize: json['fontSize'],
    );
  }
}
