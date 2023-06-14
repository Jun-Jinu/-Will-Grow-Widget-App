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

  bool showCalendar = false; // 캘린더 토글 변수

  int selectedIndex = 0;
  bool isChecked = false; // 체크박스의 초기 상태

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  void delControllerValue() {
    contentController.text = "";
    promiseController.text = "";
    showCalendar = false;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    selectedIndex = 0;
    isChecked = false;
  }

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void toggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onConfirmPressed() {
    toggleCalendar();
  }

  // 체크박스의 상태 변경 시 호출되는 콜백 함수
  void onCheckboxChanged(bool value) {
    isChecked = value; // 체크박스의 상태 변경
    notifyListeners();
  }

  // 체크박스의 토글시 호출되는 콜백 함수
  void toggleCheckbox() {
    isChecked = !isChecked; // 체크박스의 상태 변경
    notifyListeners();
  }

  void onChangeWeather(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }

  Future<void> savePost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이값으로 재정의
        id: 0,
        weatherIndex: selectedIndex,
        content: contentController.text,
        promise: promiseController.text,
        date: selectedDay,
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
