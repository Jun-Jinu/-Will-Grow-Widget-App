import 'package:flutter/material.dart';
import 'package:board_widget/ui/settings/app_setting/app_settings_viewmodel.dart';

class DarkTheme {
  static ThemeData getThemeData(AppSettingsViewModel appSettingsViewModel) {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: appSettingsViewModel.primaryColor,
        secondary: appSettingsViewModel.secondaryColor,
      ),
      textTheme:
          Typography().white.apply(fontFamily: appSettingsViewModel.fontFamily),
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        foregroundColor: Color(0xff333333),
        backgroundColor: Colors.white,
      ),
    );
  }
}
