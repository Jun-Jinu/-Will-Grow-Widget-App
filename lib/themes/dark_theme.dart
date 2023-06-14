import 'package:flutter/material.dart';
import 'package:board_widget/ui/settings/app_setting/app_settings_viewmodel.dart';

class DarkTheme {
  static ThemeData getThemeData(AppSettingsViewModel appSettingsViewModel) {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.red,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
