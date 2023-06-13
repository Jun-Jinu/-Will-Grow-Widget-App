import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:board_widget/data/model/post/post.dart';

import 'package:board_widget/data/repository/post_repository.dart';

class PostEditViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  PostEditViewModel() {
    _postRepository = PostRepository();
  }

  final TextEditingController contentController = TextEditingController();
  final TextEditingController promiseController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  bool showCalendar = false;
  int postId = -1;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void setPost(Post post) {
    //post ID 저장
    postId = post.id;

    // 기존 post값 동기화
    contentController.text = post.content;
    promiseController.text = post.promise;
    durationController.text =
        post.promiseEndDate.difference(post.date).inDays.abs().toString();
    selectedDay = post.date;
    focusedDay = post.date;
  }

  void toggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onConfirmPressed() {
    toggleCalendar();
  }

  Future<void> editPost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이 + 1 로 재정의
        id: postId,
        content: contentController.text,
        promise: promiseController.text,
        date: selectedDay,
        promiseEndDate:
            selectedDay.add(Duration(days: int.parse(durationController.text))),
      );

      _postRepository.updatePost(post);

      Navigator.pushNamed(context, "/post/detail", arguments: postId);
    } catch (e) {
      // 실패시 경고 알림
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("오류"),
            content: Text("일기를 저장하는 중에 오류가 발생했습니다."),
            actions: [
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }
}
