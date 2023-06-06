import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:board_widget/data/model/post.dart';
import 'package:board_widget/data/repository/post_repository.dart';
import 'package:board_widget/data/repository/menu_repository.dart';

class PostListViewModel with ChangeNotifier {
  late final PostRepository _postRepository;
  late final MenuRepository _menutRepository;

  List<Post> get items => _items;
  List<Post> _items = [];

  PostListViewModel() {
    _postRepository = PostRepository();
    _menutRepository = MenuRepository();
    _loadItems();
  }

  Future<void> _loadItems() async {
    _items = await _postRepository.getPosts();
    notifyListeners();
  }

  setSelectedIndex(int index) {
    _menutRepository.setSelectedIndex(index);
  }

  getSelectedIndex() {
    return _menutRepository.selectedIndex;
  }
}
