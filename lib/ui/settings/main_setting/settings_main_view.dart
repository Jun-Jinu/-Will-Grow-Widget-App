import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:provider/provider.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';
import '../settings_main_viewmodel.dart';

class SettingsMainView extends StatelessWidget {
  const SettingsMainView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 2,
      ),
      body: const SettingsMainBody(),
    );
  }
}

class SettingsMainBody extends StatelessWidget {
  const SettingsMainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsMainViewModel>(context);
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
          title: const Text('테마 설정'),
          tiles: [
            SettingsTile(
              title: const Text('위젯 스킨 설정'),
              onPressed: (BuildContext context) {
                viewModel.handleWidgetSkinSettings(context);
              },
            ),
            SettingsTile(
              title: const Text('앱 스킨 설정'),
              onPressed: (BuildContext context) {
                viewModel.handleAppSkinSettings(context);
              },
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('지원'),
          tiles: [
            SettingsTile(
              title: const Text('앱 리뷰 남기기'),
              onPressed: (BuildContext context) {
                // Handle contact us settings
              },
            ),
            SettingsTile(
              title: const Text('의견 보내기'),
              onPressed: (BuildContext context) {
                // Handle send feedback settings
              },
            ),
            SettingsTile(
              title: const Text('앱 공유하기'),
              onPressed: (BuildContext context) {
                // Handle share app settings
              },
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('성장다짐'),
          tiles: [
            SettingsTile(
              enabled: false,
              title: const Text('버전'),
              value: const Text('v1.0.0'), // Displayed on the right side
              onPressed: (BuildContext context) {
                // Handle version settings
              },
            ),
            SettingsTile(
              enabled: false,
              title: const Text('개발자'),
              value: Text('Jinu'), // Displayed on the right side
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