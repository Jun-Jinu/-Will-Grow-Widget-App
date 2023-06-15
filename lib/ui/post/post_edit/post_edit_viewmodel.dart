import 'package:board_widget/data/model/home_widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:board_widget/data/model/post/post.dart';

import 'package:board_widget/data/repository/post_repository.dart';

class PostEditViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  PostEditViewModel() {
    _postRepository = PostRepository();
  }

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  bool showCalendar = false; // 캘린더 토글 변수
  int postId = 0;
  int selectedWeatherIndex = 0;
  String contentText = "";
  String promiseText = "";

  bool isCheckedWidgetText = false; // 주요 목표 체크박스
  bool _previousCheckedWidgetText = false;

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void delControllerValue() {
    contentText = "";
    promiseText = "";
    showCalendar = false;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    selectedWeatherIndex = 0;
    isCheckedWidgetText = false;
  }

// post를 불러오는 함수
  void onLoadPost(Post post) async {
    //post ID 저장
    postId = post.id;

    // 기존 post값 동기화
    selectedWeatherIndex = post.weatherIndex;
    contentText = post.content;
    promiseText = post.promise;
    selectedDay = post.date;
    focusedDay = post.date;

    // 목표 위젯 ID 받기
    int widgetId = await _postRepository.getWidgetId();

    postId == widgetId
        ? isCheckedWidgetText = true
        : isCheckedWidgetText = false;

    // 과도한 State업데이트 방지
    if (isCheckedWidgetText != _previousCheckedWidgetText) {
      notifyListeners();
      _previousCheckedWidgetText = isCheckedWidgetText;
    }
  }

  void onToggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onPressdConfirm() {
    onToggleCalendar();
  }

  void onSavedContent(String? value) {
    contentText = value!;
  }

  void onSavedPromise(String? value) {
    promiseText = value!;
  }

  // 체크박스의 상태 변경 시 호출되는 콜백 함수
  void onCheckboxChanged(bool value) {
    isCheckedWidgetText = value; // 체크박스의 상태 변경
    notifyListeners();
  }

  // 체크박스의 토글시 호출되는 콜백 함수
  void toggleCheckbox() {
    isCheckedWidgetText = !isCheckedWidgetText; // 체크박스의 상태 변경
    notifyListeners();
  }

  void onChangeWeather(int index) {
    selectedWeatherIndex = index;
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }

  String? validateContent(String? value) {
    if (value == null || value.isEmpty) {
      return '오늘 당신을 짧게나마 기록해보세요';
    }
    return null;
  }

  String? validatePromise(String? value) {
    if (value == null || value.isEmpty) {
      return '당신의 오늘 다짐을 알고싶어요';
    }
    return null;
  }

  Future<void> updatePost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이값으로 재정의
        id: 0,
        weatherIndex: selectedWeatherIndex,
        content: contentText,
        promise: promiseText,
        date: selectedDay,
      );

      int postId = await _postRepository.updatePost(post);

      // 새로운 핵심 목표일 경우 홈위젯 업데이트
      if (isCheckedWidgetText)
        _postRepository.updateWidgetText(
            HomeWidget(postId: postId, homeWidgetText: promiseText));

      Navigator.pushNamed(context, "/post/detail", arguments: postId);

      // 모든 입력칸을 초기화
      delControllerValue();
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
