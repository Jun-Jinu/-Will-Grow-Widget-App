import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:board_widget/data/model/post/post.dart';

import 'package:board_widget/data/repository/post_repository.dart';

class NewPostViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  NewPostViewModel() {
    _postRepository = PostRepository();
  }

  final TextEditingController contentController = TextEditingController();
  final TextEditingController promiseController = TextEditingController();
  final TextEditingController directInputController = TextEditingController();

  int promiseDuration = 1;
  bool onDirect = false;
  bool showCalendar = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  void delControllerValue() {
    contentController.text = "";
    promiseController.text = "";
    promiseDuration = 1;
    onDirect = false; // 직접입력 변수(true: 직접입력)
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

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }

  void onPromiseDurationChanged(int? value) {
    // 직접입력
    if (value == -3) {
      onDirect = true;
    } else {
      onDirect = false;
      // 다짐 일 값 저장
      promiseDuration = value!;
    }

    notifyListeners();
  }

  Future<void> savePost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이값으로 재정의
        id: 0,
        content: contentController.text,
        promise: promiseController.text,
        date: selectedDay,
        // True: 직접 입력 날을 추가, False: 정해진 날을 추가
        promiseEndDate: onDirect
            ? selectedDay
                .add(Duration(days: int.parse(directInputController.text)))
            : selectedDay.add(Duration(days: promiseDuration)),
      );

      _postRepository.addPost(post);

      // 모든 입력칸을 초기화
      delControllerValue();

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
}
