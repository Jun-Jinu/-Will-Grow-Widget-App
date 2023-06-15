import 'package:flutter/material.dart';
import 'package:board_widget/ui/settings/app_setting/app_settings_viewmodel.dart';

class LightTheme {
  static ThemeData getThemeData(AppSettingsViewModel appSettingsViewModel) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: appSettingsViewModel.primaryColor,
        secondary: appSettingsViewModel.secondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        foregroundColor: Color(0xff333333),
        backgroundColor: Colors.white,
      ),
      fontFamily: appSettingsViewModel.fontFamily,
    );
  }
}
