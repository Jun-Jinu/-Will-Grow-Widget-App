import 'package:flutter/material.dart';
import 'package:board_widget/data/repository/post_repository.dart';
import 'package:board_widget/data/model/post.dart';

class PostListViewModel with ChangeNotifier {
  late final PostRepository _postRepository;

  PostListViewModel() {
    _postRepository = PostRepository();
  }

  Future<List<Post>?> loadItems() async {
    try {
      return _postRepository.getPosts();
    } catch (e) {
      return null;
    }
  }
}
