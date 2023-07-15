import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // 앱 공유하기
}
