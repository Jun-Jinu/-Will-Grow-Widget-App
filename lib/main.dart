import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

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

import 'package:board_widget/data/model/post/post.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';
import 'package:board_widget/data/model/theme/widget/widget_settings.dart';
import 'package:board_widget/data/model/adapters/color_apapter.dart';
import 'package:board_widget/data/model/home_widget/home_widget.dart';

import 'package:board_widget/routes/routes.dart';

void main() async {
  await Hive.initFlutter();

  // HIVE Color 추가(등록은 type ID 순)
  Hive.registerAdapter<Color>(ColorAdapter());

  // HIVE Adapter 등록
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(WidgetSettingsAdapter());
  Hive.registerAdapter(HomeWidgetAdapter());

  // 로컬스토리지(HIVE) 불러오기
  await Hive.openBox<Post>('postbox');
  await Hive.openBox<int>('postIndexBox');
  var appBox = await Hive.openBox<AppSettings>('appSettingsBox');
  var widgetBox = await Hive.openBox<WidgetSettings>('widgetSettingsBox');
  var homeWidgetBox = await Hive.openBox<HomeWidget>('homeWidgetBox');

  // 앱 설정 로드
  final appSettings = AppSettings(
      isDarkModeEnabled: false,
      backgroundColor: Colors.white,
      fontFamily: "KyoboHandwriting",
      fontSize: 1.0,
      dateFormat: "");

  final widgetSettings = WidgetSettings(
    isTextChangeHourly: true,
    isTextChangeHour: 24,
    fontColor: "black",
    backgroundColor: "white",
    fontFamily: "KyoboHandwriting",
    fontSize: 24.0,
  );

  final homeWidget = HomeWidget(
      postId: 0, homeWidgetText: "아직 설정한 목표가 없습니다!\n일기를 작성하고 목표를 설정해보세요");

  // 초기값 설정
  appBox.put(0, appSettings);
  widgetBox.put(0, widgetSettings);
  homeWidgetBox.put(0, homeWidget);

  WidgetsFlutterBinding.ensureInitialized();

  // locale 을 위한 초기화
  await initializeDateFormatting();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final appSettingsViewModel = Provider.of<AppSettingsViewModel>(context);

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
      theme: ThemeData(
        primaryColor: const Color(0xff9b59b6),
        scaffoldBackgroundColor: appSettingsViewModel.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0.5,
          foregroundColor: Color(0xff333333), // 글자 색
          backgroundColor: Colors.white,
        ),
        fontFamily: appSettingsViewModel.fontFamily,
      ),
      darkTheme: ThemeData.dark(),
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
