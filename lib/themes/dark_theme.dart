import 'package:flutter/material.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';

class DarkTheme {
  static ThemeData getThemeData(AppSettings appSettings) {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: appSettings.primaryColor,
        secondary: appSettings.secondaryColor,
      ),
      textTheme: Typography().white.apply(fontFamily: appSettings.fontFamily),
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        foregroundColor: Color(0xffeeeeee),
        backgroundColor: Color(0xff444444),
      ),
    );
  }
}
