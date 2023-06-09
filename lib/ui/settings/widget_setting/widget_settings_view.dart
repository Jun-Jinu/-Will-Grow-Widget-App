import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

class WidgetSettingBody extends StatelessWidget {
  const WidgetSettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.blue, // 배경색 설정
            borderRadius: BorderRadius.circular(20), // 모서리를 둥글게 설정
          ),
          child: Center(
            child: Text(
              '파이팅 해야지!',
              style: TextStyle(fontSize: 28),
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
                title: const Text('다짐'),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) {},
                    initialValue: true,
                    title: Text('시간별 텍스트 변경'),
                  ),
                  SettingsTile(
                    title: const Text('시간1'),
                    onPressed: (BuildContext context) {
                      // Handle contact us settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('시간1'),
                    onPressed: (BuildContext context) {
                      // Handle send feedback settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('시간1'),
                    onPressed: (BuildContext context) {
                      // Handle share app settings
                    },
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('배경색'),
                tiles: [
                  SettingsTile(
                    title: const Text('배경화면1'),
                    onPressed: (BuildContext context) {
                      // Handle background settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('배경화면1'),
                    onPressed: (BuildContext context) {
                      // Handle font settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('배경화면1'),
                    onPressed: (BuildContext context) {
                      // Handle conversion cycle settings
                    },
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
                      // Handle version settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('보통'),
                    onPressed: (BuildContext context) {
                      // Handle developer settings
                    },
                  ),
                  SettingsTile(
                    title: const Text('작게'),
                    onPressed: (BuildContext context) {
                      // Handle developer settings
                    },
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
