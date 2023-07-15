import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

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

  Future<void> launchReviewURL() async {
    if (!await launchUrl(
        Uri.parse('https://apps.apple.com/app/id6450313724'))) {
      throw Exception('Could not launch');
    }
  }

  // 의견 보내기
  Future<String> getEmailBody() async {
    String body = "";

    body += "==============\n";
    body += "아래 내용을 함께 보내주시면 큰 도움이 됩니다!\n";
    body += "==============\n";

    return body;
  }

  void sendEmail() async {
    String body = await getEmailBody();

    final Email email = Email(
      body: body,
      subject: '[성장다짐 문의]',
      recipients: ['willgrow.official@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title =
          "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 최선을 다해 답변해드리고 반영해보겠습니다 :)\n\nyouwillgrow.official@gmail.com";
      String message = "";
      // _showErrorAlert(title: title, message: message);
    }
  }

  // 앱 공유하기
  void shareApp() async {
    Share.share(
        '끊임없이 성장하는 당신과 함께\n\n 매일 일기를 쓰며 다짐을 기록하는 당신만의 일기장, 윌그로우\n\n당신의 멋진 오늘을 기록하고, 다짐해보세요! 그리고 홈 위젯으로 매일 보며 목표를 이뤄보세요!\n\nhttps://apps.apple.com/app/id6450313724');
  }

//   void _showErrorAlert({required String title, required String message}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: Text('확인'),
//             onPressed: () {
//               Navigator.pop(context); // 다이얼로그 닫기
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
}
