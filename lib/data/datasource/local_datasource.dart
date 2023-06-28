import 'dart:io';

import 'package:flutter/material.dart';

import '../model/post/post.dart';
import '../model/theme/app/app_settings.dart';
import '../model/theme/widget/widget_settings.dart';
import '../model/home_widget_info/home_widget_info.dart';

import 'dart:convert';

import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:hive/hive.dart';
import 'package:home_widget/home_widget.dart';

class LocalDataSource {
  /// 일기를 가져옴
  Future<List<Post>> getPosts() async {
    var postBox = Hive.box<Post>('postBox');
    return postBox.values.toList();
  }

  /// ID로 특정 일기를 가져옴
  Future<Post> getPostById(int id) async {
    var postBox = Hive.box<Post>('postBox');
    var post = postBox.get(id);

    if (post == null) {
      throw Exception('일기를 찾을 수 없습니다.'); // 예외 처리
    }
    return post;
  }

  /// ID로 특정 일기를 삭제함
  Future<void> deletePostById(int id) async {
    var postBox = Hive.box<Post>('postBox');
    await postBox.delete(id);
  }

  /// 일기를 수정함
  Future<int> updatePost(Post updatedPost) async {
    var postBox = Hive.box<Post>('postBox');
    await postBox.put(updatedPost.id, updatedPost);

    return updatedPost.id;
  }

  /// 일기를 추가함
  Future<int> addPost(Post newPost) async {
    var postBox = Hive.box<Post>('postBox');

    // post의 index만 기록하는 LOCAL STORAGE
    var postIndexBox = Hive.box<int>('postIndexBox');
    int currentCounter = postIndexBox.isEmpty ? -1 : postIndexBox.getAt(0)!;

    // 이전 값에서 id를 1씩 올리면서 부여(삭제할 경우 빈 id가 됨)
    newPost.id = currentCounter + 1;

    // 새로운 일기 추가
    await postBox.add(newPost);
    // Index Hive 업데이트
    await postIndexBox.put(0, newPost.id);

    return newPost.id;
  }

  // 홈 위젯 텍스트 변경(대표 일기 변경)
  Future<void> updateWidgetText(HomeWidgetInfo homeWidget) async {
    var homeWidgetBox = Hive.box<HomeWidgetInfo>('homeWidgetBox');

    await homeWidgetBox.put(0, homeWidget);

    // (Android) Widget 텍스트 업데이트)
    if (Platform.isAndroid) {
      await HomeWidget.saveWidgetData<String>(
          'mainText', homeWidget.homeWidgetText);
      await HomeWidget.updateWidget(
          name: 'HomeScreenWidgetProvider',
          iOSName: 'HomeScreenWidgetProvider');
    }

    // (IOS) Widget 텍스트 업데이트
    if (Platform.isIOS) {
      WidgetKit.setItem(
          'WidgetData',
          jsonEncode(HomeWidgetInfo(
            postId: homeWidget.postId,
            homeWidgetText: homeWidget.homeWidgetText,
          )),
          'group.boardwidget');

      WidgetKit.reloadAllTimelines();
    }
  }

  // 홈 위젯 ID 반환
  Future<int> getWidgetId() async {
    var homeWidgetBox = Hive.box<HomeWidgetInfo>('homeWidgetBox');

    var homeWidget = homeWidgetBox.getAt(0);
    var postId = homeWidget!.postId;

    return postId;
  }

  // -------------------------------- //
  // 앱 세팅 메서드

  /// 앱 세팅을 가져옴
  Future<AppSettings> getAppSettings() async {
    var appSettingsBox = Hive.box<AppSettings>('appSettingsBox');
    return appSettingsBox.get(0)!;
  }

  /// 앱 세팅을 업데이트
  Future<void> updateAppSettings({
    bool? isDarkModeEnabled,
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
    double? fontSize,
    String? dateFormat,
  }) async {
    var appSettingsBox = Hive.box<AppSettings>('appSettingsBox');
    var settings = appSettingsBox.get(0);

    if (settings != null) {
      if (isDarkModeEnabled != null) {
        settings.isDarkModeEnabled = isDarkModeEnabled;
      }
      if (primaryColor != null) {
        settings.primaryColor = primaryColor;
      }
      if (secondaryColor != null) {
        settings.secondaryColor = secondaryColor;
      }
      if (fontFamily != null) {
        settings.fontFamily = fontFamily;
      }
      if (fontSize != null) {
        settings.fontSize = fontSize;
      }
      if (dateFormat != null) {
        settings.dateFormat = dateFormat;
      }

      await appSettingsBox.put(0, settings);
    }
  }
  // -------------------------------- //
  // 위젯 세팅 매서드

  /// 앱 세팅을 가져옴
  Future<WidgetSettings> getWidgetSettings() async {
    var widgetSettingsBox = Hive.box<WidgetSettings>('widgetSettingsBox');
    return widgetSettingsBox.get(0)!;
  }

  /// 앱 세팅을 업데이트
  Future<void> updateWidgetSettings({
    bool? isTextChangeHourly,
    int? isTextChangeHour,
    String? fontColor,
    String? backgroundColor,
    String? fontFamily,
    double? fontSize,
  }) async {
    var widgetSettingsBox = Hive.box<WidgetSettings>('widgetSettingsBox');
    var settings = widgetSettingsBox.get(0);

    if (settings != null) {
      if (isTextChangeHourly != null) {
        settings.isTextChangeHourly = isTextChangeHourly;
      }
      if (isTextChangeHour != null) {
        settings.isTextChangeHour = isTextChangeHour;
      }
      if (fontColor != null) {
        settings.fontColor = fontColor;

        if (Platform.isAndroid) {
          await HomeWidget.saveWidgetData<String>(
              'fontColor', getColorFromName(fontColor));
        }
      }
      if (backgroundColor != null) {
        settings.backgroundColor = backgroundColor;

        if (Platform.isAndroid) {
          await HomeWidget.saveWidgetData<String>(
              'backgroundColor', getColorFromName(backgroundColor));
        }
      }
      if (fontFamily != null) {
        settings.fontFamily = fontFamily;
      }
      if (fontSize != null) {
        settings.fontSize = fontSize;

        if (Platform.isAndroid) {
          await HomeWidget.saveWidgetData<int>('fontSize', fontSize.toInt());
        }
      }

      await widgetSettingsBox.put(0, settings);

      if (Platform.isAndroid) {
        await HomeWidget.updateWidget(
            name: 'HomeScreenWidgetProvider',
            iOSName: 'HomeScreenWidgetProvider');
      }

      if (Platform.isIOS) {
        WidgetKit.setItem(
            'WidgetSettings',
            jsonEncode(WidgetSettings(
              isTextChangeHourly: settings.isTextChangeHourly,
              isTextChangeHour: settings.isTextChangeHour,
              fontColor: settings.fontColor,
              backgroundColor: settings.backgroundColor,
              fontFamily: settings.fontFamily,
              fontSize: settings.fontSize,
            )),
            'group.boardwidget');

        WidgetKit.reloadAllTimelines();
      }
    }
  }
}

String getColorFromName(String name) {
  switch (name) {
    case 'black':
      return "#333333";
    case 'grey':
      return "#939597";
    case 'white':
      return "#e9e9e9";
    case 'navy':
      return "#11264f";
    case 'yellow':
      return "#f5df4d";
    case 'light_grey':
      return "#D3D3D3";
    default:
      // 기본적으로 검정색("#000000")을 반환합니다.
      return "#333333";
  }
}
