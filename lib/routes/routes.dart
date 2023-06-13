import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:board_widget/ui/post/post_list/post_list_view.dart';
import 'package:board_widget/ui/post/post_detail/post_detail_view.dart';
import 'package:board_widget/ui/new_post/new_post_view.dart';
import 'package:board_widget/ui/settings/main_setting/settings_main_view.dart';
import 'package:board_widget/ui/settings/widget_setting/widget_settings_view.dart';
import 'package:board_widget/ui/settings/app_setting/app_settings_view.dart';
import 'package:board_widget/ui/post/post_edit/post_edit_view.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';

// 라우팅 설정
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return deleteAnimationPageRoute(page: NewPostView());
    case '/post':
      return deleteAnimationPageRoute(page: PostListView());
    case '/post/detail':
      return MaterialPageRoute(
          builder: (context) => PostDetailView(), settings: settings);
    case '/post/edit':
      return MaterialPageRoute(
          builder: (context) => PostEditView(), settings: settings);
    case '/settings':
      return deleteAnimationPageRoute(page: SettingsMainView());
    case '/settings/widget':
      return deleteAnimationPageRoute(page: WidgetSettingView());
    case '/settings/app':
      return deleteAnimationPageRoute(page: AppSettingsView());
    default:
      return null;
  }
}

// 화면 전환 애니메이션 제거 라우터
class deleteAnimationPageRoute extends PageRouteBuilder {
  final Widget page;

  deleteAnimationPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

Future<void> initializeAppSettings() async {
  final appSettingsBox = await Hive.openBox<AppSettings>('appSettingsBox');

  // 앱 설정 로드
  final appSettings = AppSettings(
      isDarkModeEnabled: false,
      backgroundColor: Colors.white,
      fontFamily: "",
      fontSize: 1.0,
      dateFormat: "");

  // 초기값 설정
  appSettingsBox.put(0, appSettings);
}
