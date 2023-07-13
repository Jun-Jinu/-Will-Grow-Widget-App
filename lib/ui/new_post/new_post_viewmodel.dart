import 'package:board_widget/data/model/home_widget_info/home_widget_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:board_widget/data/model/post/post.dart';

import 'package:board_widget/data/repository/post_repository.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:board_widget/api/ad_helper.dart';

class NewPostViewModel extends ChangeNotifier {
  late final PostRepository _postRepository;

  NewPostViewModel() {
    _postRepository = PostRepository();
  }

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  // BannerAd? _bannerAd;
  bool showCalendar = false; // 캘린더 토글 변수
  int selectedIndex = 0;
  String contentText = "";
  String promiseText = "";

  bool isCheckedWidgetText = false; // 주요 목표 체크박스

  String get formattedDate => DateFormat('yyyy.MM.dd').format(selectedDay);

  // void loadBanner() {
  //   BannerAd(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     request: AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _bannerAd = ad as BannerAd;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         print('Failed to load a banner ad: ${err.message}');
  //         ad.dispose();
  //       },
  //     ),
  //   ).load();
  // }

  void delControllerValue() {
    contentText = "";
    promiseText = "";
    showCalendar = false;
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
    selectedIndex = 0;
    isCheckedWidgetText = false;
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
    selectedIndex = index;
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

  Future<void> savePost(BuildContext context) async {
    try {
      final post = Post(
        // id는 local_datasource에서 길이값으로 재정의
        id: 0,
        weatherIndex: selectedIndex,
        content: contentText,
        promise: promiseText,
        date: selectedDay,
      );

      int postId = await _postRepository.addPost(post);

      // 새로운 핵심 목표일 경우 홈위젯 업데이트
      if (isCheckedWidgetText)
        _postRepository.updateWidgetText(
            HomeWidgetInfo(postId: postId, homeWidgetText: promiseText));

      Navigator.pushNamed(context, "/post");

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
