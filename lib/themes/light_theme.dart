import 'package:flutter/material.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';

class LightTheme {
  static ThemeData getThemeData(AppSettings appSettings) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: appSettings.primaryColor,
        secondary: appSettings.secondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        foregroundColor: Color(0xff333333),
        backgroundColor: Colors.white,
      ),
      fontFamily: appSettings.fontFamily,
    );
  }
}
