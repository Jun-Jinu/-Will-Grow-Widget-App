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
                // viewModel.selectBackground(index);
              },
              trailing: viewModel == 'white'
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
              title: Text("font"),
              onPressed: (BuildContext context) {
                viewModel.selectFont("");
              },
              trailing: viewModel.fontFamily == "default"
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
          ],
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('글자 크기'),
          tiles: [
            SettingsTile(
              title: Text("작게"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(20.0);
              },
              trailing: viewModel.fontSize == 20.0
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text("보통"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(24.0);
              },
              trailing: viewModel.fontSize == 24.0
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
            SettingsTile(
              title: Text("크게"),
              onPressed: (BuildContext context) {
                viewModel.selectFontSize(28.0);
              },
              trailing: viewModel.fontSize == 28.0
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
              title: Text("2023/03/02"),
              onPressed: (BuildContext context) {
                viewModel.selectDateFormat("22");
              },
              trailing: viewModel.dateFormat == "22"
                  ? Icon(Icons.check, color: Colors.blue)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
