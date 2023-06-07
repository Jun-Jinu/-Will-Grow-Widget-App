import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class WidgetSettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 2,
      ),
      body: const WidgetSettingBody(),
    );
  }
}

class WidgetSettingBody extends StatelessWidget {
  const WidgetSettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      sections: [
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          tiles: [
            SettingsTile(
              title: const Text('프리미엄 혜택'),
              onPressed: (BuildContext context) {
                // Handle premium benefits settings
              },
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('배경'),
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
          title: const Text('다짐 변환 주기'),
          tiles: [
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
            ),
          ],
        ),
      ],
    );
  }
}
