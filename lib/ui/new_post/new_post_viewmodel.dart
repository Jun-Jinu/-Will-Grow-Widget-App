import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/data/repository/post_repository.dart';

import 'package:board_widget/data/repository/menu_repository.dart';

class NewPostViewModel with ChangeNotifier {
  late final PostRepository _postRepository;
  late final MenuRepository _menutRepository;

  NewPostViewModel() {
    _postRepository = PostRepository();
    _menutRepository = MenuRepository();
  }

  Future<void> savePost(String title, String content) async {
    // Validate the inputs, e.g., check if title and content are not empty

    // Call the postRepository to save the new post
    // await _postRepository.savePost(title, content);
  }

  setSelectedIndex(int index) {
    _menutRepository.setSelectedIndex(index);
  }

  getSelectedIndex() {
    return _menutRepository.selectedIndex;
  }
}
