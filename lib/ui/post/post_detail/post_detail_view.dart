import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:board_widget/data/model/post.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class PostDetailView extends StatelessWidget {
  final int id;

  PostDetailView({required this.id});
  final box = Hive.box<Post>('postbox');

  void deletePost(int id) {
    box.delete(id);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          '${post.date.year}.${post.date.month}.${post.date.day}',
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // 수정 옵션 선택 시 처리
                // TODO: 수정 기능 구현
                print('수정');
              } else if (value == 'delete') {
                // 삭제 옵션 선택 시 처리
                showDeleteConfirmationDialog(context);
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
        child: Column(
          children: [
            Container(
              width: double.infinity, // 화면 가로를 100%로 설정
              margin: EdgeInsets.only(
                  top: 16.0, left: 16.0, bottom: 4.0, right: 16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    '${post.promise}',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // 수정 아이콘 클릭 시 처리
                    // TODO: 수정 기능 구현
                    print('수정');
                  },
                  icon: Icon(
                    CupertinoIcons.pencil,
                    size: 32,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // 삭제 아이콘 클릭 시 처리
                    showDeleteConfirmationDialog(context);
                  },
                  icon: Icon(
                    CupertinoIcons.delete,
                    size: 28,
                  ),
                ),
                SizedBox(width: 6.0)
              ],
            )
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
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
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text('정말 일기를 삭제하시겠습니까?')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 취소 버튼 클릭 시 동작(창닫기)
                Navigator.of(context).pop();
              },
              child: Icon(
                CupertinoIcons.clear,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                // 삭제 버튼 클릭 시 동작
                deletePost(3); // 여기서 id는 삭제할 post의 id입니다.
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
}
