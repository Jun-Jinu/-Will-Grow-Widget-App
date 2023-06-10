import 'package:flutter/material.dart';
import 'package:board_widget/data/repository/post_repository.dart';
import 'package:board_widget/data/model/post.dart';

class PostListViewModel with ChangeNotifier {
  late final PostRepository _postRepository;

  List<Post> get items => _items;
  List<Post> _items = [];

  PostListViewModel() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    _items = await _postRepository.getPosts();
    notifyListeners();
  }
}
