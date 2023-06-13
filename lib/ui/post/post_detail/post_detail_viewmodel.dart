import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:board_widget/data/model/post/post.dart';
import 'package:board_widget/data/repository/post_repository.dart';

class PostDetailViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  PostDetailViewModel() {
    _postRepository = PostRepository();
  }

  String getDDayText(Post post) {
    final now = DateTime.now();
    final daysLeft = post.promiseEndDate.difference(now).inDays + 1;
    return daysLeft > 0 ? 'D-${daysLeft}' : 'D+${daysLeft.abs()}';
  }

  Future<Post?> getPostById(int id) async {
    try {
      print(id);
      return _postRepository.getPostById(id);
    } catch (e) {
      // 예외 처리
      print('일기 조회 중 오류 발생: $e');
      // 오류 메시지를 보여주거나 다른 작업 수행
      return null;
    }
  }

  Future<void> deletePost(BuildContext context, Post post) async {
    try {
      // 일기 삭제
      await _postRepository.deletePostById(post.id);
      Navigator.of(context).pop();
      Navigator.pushNamed(context, '/post');
    } catch (e) {
      // 예외 처리
      print('일기 삭제 중 오류 발생: $e');
      // 오류 메시지를 보여주거나 다른 작업 수행
    }
  }

  void showDeleteConfirmationDialog(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '다짐 삭제',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text('정말 일기를 삭제하시겠습니까?')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                CupertinoIcons.clear,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                deletePost(context, post);
              },
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
