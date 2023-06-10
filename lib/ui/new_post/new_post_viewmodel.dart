import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:board_widget/data/model/post.dart';

import 'package:board_widget/data/repository/post_repository.dart';

class NewPostViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  NewPostViewModel() {
    _postRepository = PostRepository();
  }

  final TextEditingController contentController = TextEditingController();
  final TextEditingController promiseController = TextEditingController();

  int promiseDuration = 1;
  bool onDirect = false;
  bool showCalendar = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  void initController() {
    contentController.text = "";
    promiseController.text = "";
    promiseDuration = 1;
    onDirect = false;
    showCalendar = false;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
  }

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void toggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onConfirmPressed() {
    toggleCalendar();
  }

  Future<void> savePost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이 + 1 로 재정의
        id: 0,
        content: contentController.text,
        promise: promiseController.text,
        date: selectedDay,
        promiseEndDate: selectedDay.add(Duration(days: promiseDuration)),
      );

      _postRepository.addPost(post);

      initController();

      Navigator.pushNamed(context, "/post");
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

  void onPromiseDurationChanged(int? value) {
    if (value == -3) {
      onDirect = true;
    } else {
      onDirect = false;
    }
    notifyListeners();
  }
}
