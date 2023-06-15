import 'package:flutter/material.dart';

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
      return NoAnimationPageRoute(
        builder: (context) => NewPostView(),
      );
    case '/post':
      return NoAnimationPageRoute(
          builder: (context) => PostListView(), maintainState: false);
    case '/post/detail':
      return MaterialPageRoute(
        builder: (context) => PostDetailView(),
        settings: settings,
        maintainState: false,
      );
    case '/post/edit':
      return MaterialPageRoute(
          builder: (context) => PostEditView(), settings: settings);
    case '/settings':
      return NoAnimationPageRoute(builder: (context) => SettingsMainView());
    case '/settings/widget':
      return NoAnimationPageRoute(builder: (context) => WidgetSettingView());
    case '/settings/app':
      return NoAnimationPageRoute(builder: (context) => AppSettingsView());
    default:
      return null;
  }
}

// 화면 전환 애니메이션 제거
class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      bool maintainState = true})
      : super(
            builder: builder, settings: settings, maintainState: maintainState);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child; // 애니메이션을 제거하고 child 위젯을 직접 반환합니다.
  }

  @override
  Duration get transitionDuration => Duration.zero; // 애니메이션의 지속 시간을 0으로 설정합니다.
}

// Future<void> initializeAppSettings() async {
//   final appSettingsBox = await Hive.openBox<AppSettings>('appSettingsBox');

//   // 앱 설정 로드
//   final appSettings = AppSettings(
//       isDarkModeEnabled: false,
//       primaryColor: Colors.white,
//       secondaryColor: Colors.white,
//       fontFamily: "",
//       fontSize: 1.0,
//       dateFormat: "");

//   // 초기값 설정
//   appSettingsBox.put(0, appSettings);
// }
