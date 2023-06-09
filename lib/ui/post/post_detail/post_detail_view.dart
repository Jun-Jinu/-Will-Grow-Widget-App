import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

    final now = DateTime.now();
    final daysLeft = post.promiseEndDate.difference(now).inDays;
    final dDayText = daysLeft > 0 ? 'D-${daysLeft}' : 'D+${daysLeft.abs()}';

    return Scaffold(
      appBar: AppBar(
        title: Text('글 상세 정보'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // 수정 옵션 선택 시 처리
                // TODO: 수정 기능 구현
                print('수정');
              } else if (value == 'delete') {
                // 삭제 옵션 선택 시 처리
                // TODO: 삭제 기능 구현
                print('삭제');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('수정'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('삭제'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 8.0),
              Text(
                '${post.date.year}.${post.date.month}.${post.date.day}',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '- ${post.promise} -',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 8.0),
              Text(
                dDayText,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
