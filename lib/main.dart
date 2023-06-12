import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

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

import 'dart:convert';

import 'package:board_widget/data/model/post/post.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';
import 'package:board_widget/data/model/theme/widget/widget_settings.dart';
import 'package:board_widget/data/model/adapters/color_apapter.dart';

void main() async {
  await Hive.initFlutter();

  // HIVE Color 추가
  Hive.registerAdapter<Color>(ColorAdapter());

  // HIVE Adapter 등록
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(WidgetSettingsAdapter());

  // 로컬스토리지(HIVE) 불러오기
  await Hive.openBox<Post>('postbox');
  await Hive.openBox<int>('postIndexBox');
  var box = await Hive.openBox<AppSettings>('appSettingsBox');
  await Hive.openBox<WidgetSettings>('widgetSettingsBox');

  // 앱 설정 로드
  final appSettings = AppSettings(
      isDarkModeEnabled: false,
      backgroundColor: Colors.white,
      fontFamily: "",
      fontSize: 24.0,
      dateFormat: "");

  // 초기값 설정
  box.put(0, appSettings);

  // initializeAppSettings();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

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
      ],
      child: MaterialApp(
        onGenerateRoute: (route) => onGenerateRoute(route),
        debugShowCheckedModeBanner: false,
        title: '나의 앱 ~',
        theme: ThemeData(
          primaryColor: Colors.black87,
          appBarTheme: const AppBarTheme(
            elevation: 0.5,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          primarySwatch: Colors.lightBlue,
          fontFamily: "KyoboHandwriting",
        ),
        initialRoute: '/',
      ),
    );
  }
}

// 라우팅 설정
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return delAnimationPageRoute(page: NewPostView());
    case '/post':
      return delAnimationPageRoute(page: PostListView());
    case '/post/detail':
      return MaterialPageRoute(
          builder: (context) => PostDetailView(), settings: settings);
    case '/post/edit':
      return MaterialPageRoute(
          builder: (context) => PostEditView(), settings: settings);
    case '/settings':
      return delAnimationPageRoute(page: SettingsMainView());
    case '/settings/widget':
      return delAnimationPageRoute(page: WidgetSettingView());
    case '/settings/app':
      return delAnimationPageRoute(page: AppSettingsView());
    default:
      return null;
  }
}

// 화면 전환 애니메이션 제거 라우터
class delAnimationPageRoute extends PageRouteBuilder {
  final Widget page;

  delAnimationPageRoute({required this.page})
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
      fontSize: 24.0,
      dateFormat: "");

  // 초기값 설정
  appSettingsBox.put(0, appSettings);
}



// 위젯을 테스트했던 코드
// void main() {
//   runApp(const MaterialApp(home: TextPage()));
// }

// class TextPage extends StatefulWidget {
//   const TextPage({super.key});

//   @override
//   State<TextPage> createState() => _TextPageState();
// }

// class _TextPageState extends State<TextPage> {
//   var textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 250,
//               child: TextField(
//                 controller: textController,
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   WidgetKit.setItem(
//                       'widgetData',
//                       jsonEncode(WidgetData(textController.text)),
//                       'group.boardwidget');
//                   WidgetKit.reloadAllTimelines();
//                 },
//                 child: Text("Push to Widget"))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WidgetData {
//   final String text;
//   WidgetData(this.text);

//   WidgetData.fromJson(Map<String, dynamic> json) : text = json['text'];
//   Map<String, dynamic> toJson() => {'text': text};
// }
