import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:board_widget/data/model/post/post.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';
import 'package:board_widget/data/model/theme/widget/widget_settings.dart';
import 'package:board_widget/data/model/adapters/color_apapter.dart';
import 'package:board_widget/data/model/home_widget/home_widget.dart';

import './app.dart';

void main() async {
  // Hive(로컬스토리지) 초기화
  await initHive();

  WidgetsFlutterBinding.ensureInitialized();

  // locale을 위한 초기화
  await initializeDateFormatting();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

// Hive(로컬스토리지) 초기화
Future<void> initHive() async {
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

  // 앱 세팅 초기값 설정
  if (appBox.isEmpty) {
    final appSettings = AppSettings(
      isDarkModeEnabled: false,
      primaryColor: Color(0xff9b59b6),
      secondaryColor: Color(0xffa374db),
      fontFamily: "KyoboHandwriting",
      fontSize: 1.0,
      dateFormat: "", // 미사용 - 추후 적용 예정
    );

    appBox.put(0, appSettings);
  } else {
    appBox.get(0);
  }

// 위젯 세팅 초기값 설정
  if (widgetBox.isEmpty) {
    final widgetSettings = WidgetSettings(
      isTextChangeHourly: true,
      isTextChangeHour: 24,
      fontColor: "black",
      backgroundColor: "white",
      fontFamily: "KyoboHandwriting",
      fontSize: 24.0,
    );
    widgetBox.put(0, widgetSettings);
  }

// 홈 위젯 초기값 설정
  if (homeWidgetBox.isEmpty) {
    final homeWidget = HomeWidget(
        postId: 0, homeWidgetText: "아직 설정한 목표가 없습니다!\n일기를 작성하고 목표를 설정해보세요");
    homeWidgetBox.put(0, homeWidget);
  }
}
