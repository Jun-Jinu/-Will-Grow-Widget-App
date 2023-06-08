import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:board_widget/data/model/post.dart';

class PostDetailView extends StatelessWidget {
  final int id;

  PostDetailView({required this.id});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Post>('postbox');
    final post = box.get(id);

    if (post == null) {
      // 해당 id에 해당하는 Post가 없을 경우 처리
      return Scaffold(
        appBar: AppBar(
          title: Text('글을 찾을 수 없습니다!'),
        ),
        body: Center(
          child: Text('해당 글을 찾을 수 없습니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('글 상세 정보'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${post.id}번째 일기',
                style: TextStyle(fontSize: 28.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '${post.date.year}.${post.date.month}.${post.date.day}',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '${post.promise}',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 32.0),
              Text(
                post.content,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '다짐 종료일',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${post.promiseEndDate.year}년 ${post.promiseEndDate.month}월 ${post.promiseEndDate.day}일',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
