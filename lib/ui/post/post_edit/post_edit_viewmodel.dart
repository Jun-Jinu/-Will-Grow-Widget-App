import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/data/repository/post_repository.dart';

class PostEditViewModel with ChangeNotifier {
  late final PostRepository _postRepository;

  PostEditViewModel() {
    _postRepository = PostRepository();
  }

  Future<void> savePost(String title, String content) async {
    // Validate the inputs, e.g., check if title and content are not empty

    // Call the postRepository to save the new post
    // await _postRepository.savePost(title, content);
  }
}
