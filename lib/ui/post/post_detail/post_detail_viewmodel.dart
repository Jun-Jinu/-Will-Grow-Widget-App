import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:board_widget/data/model/post.dart';

class PostDetailViewModel extends ChangeNotifier {
  late final Box<Post> _box;

  Future<void> getPostBoxFuture() async {
    _box = await Hive.openBox<Post>('postbox');
  }

  Post? getPost(int id) {
    return _box.get(id);
  }

  String getDDayText(Post post) {
    final now = DateTime.now();
    final daysLeft = post.promiseEndDate.difference(now).inDays + 1;
    return daysLeft > 0 ? 'D-${daysLeft}' : 'D+${daysLeft.abs()}';
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
                deletePost(post.id);
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/post');
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

  void deletePost(int id) {
    _box.delete(id);
  }
}
