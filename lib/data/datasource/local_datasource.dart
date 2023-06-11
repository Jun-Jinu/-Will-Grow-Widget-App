import 'package:flutter/material.dart';

import '../model/post/post.dart';
import '../model/theme/app/app_settings.dart';
import '../model/theme/widget/widget_settings.dart';
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
  Future<void> addPost(Post newPost) async {
    var postBox = Hive.box<Post>('postBox');

    // post의 index만 기록하는 LOCAL STORAGE
    var postIndexBox = Hive.box<int>('postIndexBox');
    int currentCounter = postIndexBox.isEmpty ? 1 : postIndexBox.getAt(0)!;

    // id를 1씩 올리면서 부여(삭제할 경우 비는 id가 됨)
    newPost.id = currentCounter++;

    // 새로운 일기 추가
    await postBox.add(newPost);
  }

  // -------------------------------- //

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
      // Update the fields that are provided
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
}
