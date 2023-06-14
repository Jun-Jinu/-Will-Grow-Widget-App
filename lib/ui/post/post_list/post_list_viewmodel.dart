import 'package:flutter/material.dart';
import 'package:board_widget/data/repository/post_repository.dart';
import 'package:board_widget/data/model/post/post.dart';

class PostListViewModel with ChangeNotifier {
  late final PostRepository _postRepository;

  PostListViewModel() {
    _postRepository = PostRepository();
  }

  int widgetId = -1;
  int _previousCheckedWidgetId = -1;

  Future<List<Post>?> loadItems() async {
    try {
      return _postRepository.getPosts();
    } catch (e) {
      return null;
    }
  }

  void onCheckWidgetText(int postId) async {
    // 목표 위젯 ID 받기
    widgetId = await _postRepository.getWidgetId();

    // // 과도한 State업데이트 방지
    if (widgetId != _previousCheckedWidgetId) {
      notifyListeners();
      _previousCheckedWidgetId = widgetId;
    }
  }

  bool isWidgetText(int postId) {
    return postId == widgetId ? true : false;
  }
}
