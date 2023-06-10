import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:board_widget/data/model/post.dart';

class NewPostViewModel extends ChangeNotifier {
  final TextEditingController contentController = TextEditingController();
  final TextEditingController promiseController = TextEditingController();

  final int promiseDuration = 1;
  bool onDirect = false;
  bool showCalendar = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void init() {
    // ViewModel 초기화 로직
  }

  void toggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onConfirmPressed() {
    toggleCalendar();
  }

  void savePost(BuildContext context) async {
    try {
      var box = await Hive.openBox<Post>('postbox');

      // TODO: ID를 업데이트해서 앞 index와 id에 넣을것, repo에 연관짓기
      box.put(
        3,
        Post(
          id: 3,
          content: contentController.text,
          promise: promiseController.text,
          date: selectedDay,
          promiseEndDate: selectedDay.add(Duration(days: promiseDuration)),
        ),
      );

      Navigator.pushNamed(context, "/post");
    } catch (e) {
      // 실패시 경고 알림
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
