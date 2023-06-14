import 'package:flutter/material.dart';

import '../model/post/post.dart';
import '../model/theme/app/app_settings.dart';
import '../model/theme/widget/widget_settings.dart';
import '../model/home_widget/home_widget.dart';
import 'package:hive/hive.dart';

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
  Future<void> updatePost(Post updatedPost) async {
    var postBox = Hive.box<Post>('postBox');
    await postBox.put(updatedPost.id, updatedPost);
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
  Future<void> updateWidgetText(HomeWidget homeWidget) async {
    var homeWidgetBox = await Hive.openBox<HomeWidget>('homeWidgetBox');

    await homeWidgetBox.put(0, homeWidget);
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
    Color? backgroundColor,
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
      if (backgroundColor != null) {
        settings.backgroundColor = backgroundColor;
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
      }
      if (backgroundColor != null) {
        settings.backgroundColor = backgroundColor;
      }
      if (fontFamily != null) {
        settings.fontFamily = fontFamily;
      }
      if (fontSize != null) {
        settings.fontSize = fontSize;
      }

      await widgetSettingsBox.put(0, settings);
    }
  }
}
