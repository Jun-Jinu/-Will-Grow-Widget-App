import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/routes/routes.dart';

import 'ui/post/post_list/post_list_viewmodel.dart';
import 'ui/post/post_list/post_list_view.dart';

import './ui/post/post_detail/post_detail_view.dart';
import './ui/post/post_detail/post_detail_viewmodel.dart';

import './ui/new_post/new_post_view.dart';
import './ui/new_post/new_post_viewmodel.dart';

import 'ui/settings/main_setting/settings_main_view.dart';
import 'ui/settings/main_setting/settings_main_viewmodel.dart';

import 'ui/settings/widget_setting/widget_settings_view.dart';
import 'ui/settings/widget_setting/widget_settings_viewmodel.dart';

import 'ui/settings/app_setting/app_settings_view.dart';
import 'ui/settings/app_setting/app_settings_viewmodel.dart';

import 'ui/post/post_edit/post_edit_view.dart';
import 'ui/post/post_edit/post_edit_viewmodel.dart';

import 'package:board_widget/themes/light_theme.dart';
import 'package:board_widget/themes/dark_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewPostViewModel>(
            create: (_) => NewPostViewModel(), child: NewPostView()),
        ChangeNotifierProvider<PostListViewModel>(
            create: (_) => PostListViewModel(), child: PostListView()),
        ChangeNotifierProvider<PostDetailViewModel>(
            create: (_) => PostDetailViewModel(), child: PostDetailView()),
        ChangeNotifierProvider<PostEditViewModel>(
            create: (_) => PostEditViewModel(), child: PostEditView()),
        ChangeNotifierProvider<SettingsMainViewModel>(
            create: (_) => SettingsMainViewModel(), child: SettingsMainView()),
        ChangeNotifierProvider<WidgetSettingsViewModel>(
            create: (_) => WidgetSettingsViewModel(),
            child: WidgetSettingView()),
        ChangeNotifierProvider<AppSettingsViewModel>(
            create: (_) => AppSettingsViewModel(), child: AppSettingsView()),
        ChangeNotifierProvider<AppSettingsViewModel>(
            create: (_) => AppSettingsViewModel(), child: AppContainer()),
        ChangeNotifierProvider<AppSettingsViewModel>(
            create: (_) => AppSettingsViewModel(), child: SettingsMainView()),
        ChangeNotifierProvider<AppSettingsViewModel>(
            create: (_) => AppSettingsViewModel(), child: WidgetSettingView()),
      ],
      child: const AppContainer(),
    );
  }
}

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingsViewModel = Provider.of<AppSettingsViewModel>(context);

    return MaterialApp(
      locale: Locale('ko', "KR"),
      onGenerateRoute: (route) => onGenerateRoute(route),
      debugShowCheckedModeBanner: false,
      theme: LightTheme.getThemeData(appSettingsViewModel),
      darkTheme: DarkTheme.getThemeData(appSettingsViewModel),
      themeMode: appSettingsViewModel.isDarkModeEnabled
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: '/',
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: appSettingsViewModel.fontSize,
        ),
        child: child!,
      ),
    );
  }
}
