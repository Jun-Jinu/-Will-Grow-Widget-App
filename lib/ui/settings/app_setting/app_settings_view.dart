import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'app_settings_viewmodel.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 설정'),
      ),
      body: AppSettingBody(),
    );
  }
}

class AppSettingBody extends StatefulWidget {
  const AppSettingBody({Key? key}) : super(key: key);

  @override
  _AppSettingBodyState createState() => _AppSettingBodyState();
}

class _AppSettingBodyState extends State<AppSettingBody> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AppSettingsViewModel>(context);

    // 폰트 메뉴에 사용하는 위젯
    List<SettingsTile> fontSettingsTiles = viewModel.fontList.map((font) {
      return SettingsTile(
        title: Text(
          font['title'],
          style: TextStyle(fontFamily: font['fontFamily']),
        ),
        onPressed: (BuildContext context) {
          viewModel.selectFont(context, font['fontFamily']);
        },
        trailing: viewModel.fontFamily == font['fontFamily']
            ? Icon(Icons.check, color: Colors.blue)
            : null,
      );
    }).toList();

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
              initialValue: viewModel.isDarkModeEnabled,
              onToggle: (value) {
                viewModel.setDarkModeEnabled(value);
              },
              title: Text('다크모드'),
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('배경색'),
          tiles: [
            SettingsTile(
              title: Text('흰색'),
              onPressed: (BuildContext context) {
                viewModel.selectBackground(Colors.white);
              },
              trailing: viewModel.backgroundColor == Colors.white
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text('연한 노란색'),
              onPressed: (BuildContext context) {
                viewModel.selectBackground(Colors.yellowAccent);
              },
              trailing: viewModel.backgroundColor == Colors.yellowAccent
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text('하늘색'),
              onPressed: (BuildContext context) {
                viewModel.selectBackground(Colors.lightBlue);
              },
              trailing: viewModel.backgroundColor == Colors.lightBlue
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('폰트'),
          tiles: fontSettingsTiles,
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('글자 크기'),
          tiles: [
            SettingsTile(
              title: Text("작게"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(0.8);
              },
              trailing: viewModel.fontSize == 0.8
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text("보통"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(1.0);
              },
              trailing: viewModel.fontSize == 1.0
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text("크게"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(1.2);
              },
              trailing: viewModel.fontSize == 1.2
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
