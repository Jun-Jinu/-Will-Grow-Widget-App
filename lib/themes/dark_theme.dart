import 'package:flutter/material.dart';
import 'package:board_widget/ui/settings/app_setting/app_settings_viewmodel.dart';

class DarkTheme {
  static ThemeData getThemeData(AppSettingsViewModel appSettingsViewModel) {
    return ThemeData.dark().copyWith(
      primaryColor: appSettingsViewModel.primaryColor,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
