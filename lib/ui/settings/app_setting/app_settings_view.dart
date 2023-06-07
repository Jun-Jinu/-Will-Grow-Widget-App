import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AppSettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: const AppSettingBody(),
    );
  }
}

class AppSettingBody extends StatelessWidget {
  const AppSettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      sections: [
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('테마'),
          tiles: [
            SettingsTile.switchTile(
              leading: Icon(Icons.dark_mode),
              onToggle: (value) {},
              initialValue: true,
              title: Text('다크모드'),
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
    );
  }
}
