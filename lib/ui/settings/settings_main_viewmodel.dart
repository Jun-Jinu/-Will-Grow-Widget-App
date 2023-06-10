import 'package:flutter/material.dart';

class SettingsMainViewModel extends ChangeNotifier {
  // 프리미엄 혜택
  void handlePremiumBenefits(BuildContext context) {}

  // 위젯 스킨 설정
  void handleWidgetSkinSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings/widget');
  }

  // 앱 스킨 설정
  void handleAppSkinSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings/app');
  }

  // 앱 리뷰남기기
  // 의견 보내기
  // 앱 공유하기
}
