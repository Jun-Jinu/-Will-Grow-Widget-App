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

  // 데이터 로딩 유무 로딩
  bool isLoadData = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  bool showCalendar = false; // 캘린더 토글 변수
  int postId = 0;
  int selectedWeatherIndex = 0;

  TextEditingController contentController = TextEditingController();
  TextEditingController promiseController = TextEditingController();

  bool isCheckedWidgetText = false; // 주요 목표 체크박스
  bool _previousCheckedWidgetText = false;

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  void delControllerValue() {
    contentController.text = "";
    promiseController.text = "";
    showCalendar = false;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    selectedWeatherIndex = 0;
    isCheckedWidgetText = false;
  }

// post를 불러오는 함수
  void onLoadPost(Post post) async {
    // 첫 로딩의 경우에만 데이터 기록
    if (!isLoadData) {
      //post ID 저장
      postId = post.id;

      // 기존 post값 동기화
      selectedWeatherIndex = post.weatherIndex;
      contentController.text = post.content;
      promiseController.text = post.promise;
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
      isLoadData = true;
    }
  }

  void onDisposePost() {
    isLoadData = false;
  }

  void onToggleCalendar() {
    showCalendar = !showCalendar;
    notifyListeners();
  }

  void onPressdConfirm() {
    onToggleCalendar();
  }

  void onSavedContent(String? value) {
    contentController.text = value!;
  }

  void onSavedPromise(String? value) {
    promiseController.text = value!;
  }

  // 체크박스의 상태 변경 시 호출되는 콜백 함수
  void onCheckboxChanged(bool value) {
    isCheckedWidgetText = value; // 체크박스의 상태 변경
    notifyListeners();
  }

  // 텍스트로 체크박스의 토글시 호출되는 콜백 함수
  void onToggleCheckbox() {
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
        id: postId,
        weatherIndex: selectedWeatherIndex,
        content: contentController.text,
        promise: promiseController.text,
        date: selectedDay,
      );

      int updatedPostId = await _postRepository.updatePost(post);

      // 새로운 핵심 목표일 경우 홈위젯 업데이트
      if (isCheckedWidgetText)
        _postRepository.updateWidgetText(HomeWidget(
            postId: updatedPostId, homeWidgetText: promiseController.text));

      Navigator.pop(context);

      // 모든 입력칸을 초기화
      delControllerValue();
      //다음 수정에 다시 데이터 로팅
      onDisposePost();
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
