import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

const BIG_FONT_SIZE = 28.0;
const NOMAL_FONT_SIZE = 24.0;
const SMALL_FONT_SIZE = 20.0;

class WidgetSettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위젯 설정'),
      ),
      body: const WidgetSettingBody(),
    );
  }
}

class WidgetSettingBody extends StatefulWidget {
  const WidgetSettingBody({Key? key}) : super(key: key);

  @override
  _WidgetSettingBodyState createState() => _WidgetSettingBodyState();
}

class _WidgetSettingBodyState extends State<WidgetSettingBody> {
  Color fontColor = Colors.white; // 초기 글자색 설정
  Color backgroundColor = Colors.blueAccent; // 초기 배경색 설정
  double fontSizeSelection = NOMAL_FONT_SIZE; // 초기 글자 크기 선택 설정

  @override
  Widget build(BuildContext context) {
    void setBackgroundColor(Color color) {
      setState(() {
        backgroundColor = color;
      });
    }

    void setFontColor(Color color) {
      setState(() {
        fontColor = color;
      });
    }

    void setFontSize(double fontSize) {
      setState(() {
        fontSizeSelection = fontSize;
      });
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: backgroundColor, // 변수로 설정된 배경색 사용
            borderRadius: BorderRadius.circular(20), // 모서리를 둥글게 설정
          ),
          child: Center(
            child: Text(
              '파이팅 해야지!',
              style: TextStyle(fontSize: fontSizeSelection),
            ),
          ),
        ),
        Expanded(
          child: SettingsList(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            sections: [
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('위젯 다짐 변경 주기'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) {},
                    initialValue: true,
                    title: Text('시간별 텍스트 변경'),
                  ),
                  SettingsTile(
                    title: const Text('2시간'),
                    onPressed: (BuildContext context) {
                      // Handle contact us settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('6시간'),
                    onPressed: (BuildContext context) {
                      // Handle contact us settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('12시간'),
                    onPressed: (BuildContext context) {
                      // Handle send feedback settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('하루'),
                    onPressed: (BuildContext context) {
                      // Handle share app settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('일주일'),
                    onPressed: (BuildContext context) {
                      // Handle share app settings
                    },
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('위젯 배경색'),
                tiles: [
                  SettingsTile(
                    title: const Text('흰색'),
                    onPressed: (BuildContext context) {
                      setBackgroundColor(Colors.white);
                    },
                  ),
                  SettingsTile(
                    title: const Text('회색'),
                    onPressed: (BuildContext context) {
                      setBackgroundColor(Colors.grey);
                    },
                  ),
                  SettingsTile(
                    title: const Text('검정색'),
                    onPressed: (BuildContext context) {
                      setBackgroundColor(Colors.black);
                    },
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('글자 색'),
                tiles: [
                  SettingsTile(
                    title: const Text('흰색'),
                    onPressed: (BuildContext context) {
                      setFontColor(Colors.white);
                    },
                    trailing: fontColor == Colors.white
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('회색'),
                    onPressed: (BuildContext context) {
                      setFontColor(Colors.grey);
                    },
                    trailing: fontColor == Colors.grey
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('검정색'),
                    onPressed: (BuildContext context) {
                      setFontColor(Colors.black);
                    },
                    trailing: fontColor == Colors.black
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('폰트'),
                tiles: [
                  SettingsTile(
                    title: const Text('폰트1'),
                    onPressed: (BuildContext context) {
                      // Handle version settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('폰트2'),
                    onPressed: (BuildContext context) {
                      // Handle developer settings
                    },
                    // TODO: 요일 표시 체크박스 만들기
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('글자 크기'),
                tiles: [
                  SettingsTile(
                    title: const Text('크게'),
                    onPressed: (BuildContext context) {
                      setFontSize(BIG_FONT_SIZE);
                    },
                    trailing: fontSizeSelection == BIG_FONT_SIZE
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('보통'),
                    onPressed: (BuildContext context) {
                      setFontSize(NOMAL_FONT_SIZE);
                    },
                    trailing: fontSizeSelection == NOMAL_FONT_SIZE
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('작게'),
                    onPressed: (BuildContext context) {
                      setFontSize(SMALL_FONT_SIZE);
                    },
                    trailing: fontSizeSelection == SMALL_FONT_SIZE
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('날짜 형식'),
                tiles: [
                  SettingsTile(
                    title: const Text('방법1'),
                    onPressed: (BuildContext context) {
                      // Handle version settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('방법2'),
                    onPressed: (BuildContext context) {
                      // Handle developer settings
                    },
                    // TODO: 요일 표시 체크박스 만들기
                  ),
                ],
              ),
              // TODO:  글자 크기 조절하기
            ],
          ),
        ),
      ],
    );
  }
}
