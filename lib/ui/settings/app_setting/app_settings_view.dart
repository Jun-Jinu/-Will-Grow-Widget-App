import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import './app_settings_viewmodel.dart';
import 'package:board_widget/data/model/theme/app/app_settings.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AppSettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: FutureBuilder<AppSettings>(
        future: viewModel.loadSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다.'));
          } else {
            final appSettings =
                snapshot.data; // loadSettings()에서 반환한 AppSettings 클래스
            return AppSettingBody(appSettings: appSettings);
          }
        },
      ),
    );
  }
}

class AppSettingBody extends StatefulWidget {
  final AppSettings? appSettings;

  const AppSettingBody({Key? key, this.appSettings}) : super(key: key);

  @override
  _AppSettingBodyState createState() => _AppSettingBodyState();
}

class _AppSettingBodyState extends State<AppSettingBody> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AppSettingsViewModel>(context);
    final appSettings =
        widget.appSettings; // AppSettingBody 위젯의 appSettings 속성 사용

    if (appSettings == null) {
      return Center(child: Text('앱 설정을 불러오는데 문제가 발생했습니다.'));
    }

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
              initialValue:
                  appSettings.isDarkModeEnabled, // appSettings에서 값을 가져옴
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
          tiles: buildBackgroundTiles(viewModel),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('폰트'),
          tiles: buildFontTiles(viewModel),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('글자 크기'),
          tiles: buildFontSizeTiles(viewModel),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('날짜 형식'),
          tiles: buildDateFormatTiles(viewModel),
        ),
      ],
    );
  }

  List<SettingsTile> buildBackgroundTiles(AppSettingsViewModel viewModel) {
    return viewModel.backgroundColors
        .asMap()
        .map((index, backgroundColor) => MapEntry(
              index,
              SettingsTile(
                title: Text('배경화면${index + 1}'),
                onPressed: (BuildContext context) {
                  viewModel.selectBackground(index);
                },
                trailing: viewModel.selectedBackgroundIndex == index
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ))
        .values
        .toList();
  }

  List<SettingsTile> buildFontTiles(AppSettingsViewModel viewModel) {
    return viewModel.fonts
        .asMap()
        .map((index, font) => MapEntry(
              index,
              SettingsTile(
                title: Text(font),
                onPressed: (BuildContext context) {
                  viewModel.selectFont(index);
                },
                trailing: viewModel.selectedFontIndex == index
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ))
        .values
        .toList();
  }

  List<SettingsTile> buildFontSizeTiles(AppSettingsViewModel viewModel) {
    return viewModel.fontSizes
        .asMap()
        .map((index, fontSize) => MapEntry(
              index,
              SettingsTile(
                title: Text(fontSize.toString()),
                onPressed: (BuildContext context) {
                  viewModel.selectFontSize(index);
                },
                trailing: viewModel.selectedFontSizeIndex == index
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ))
        .values
        .toList();
  }

  List<SettingsTile> buildDateFormatTiles(AppSettingsViewModel viewModel) {
    return viewModel.dateFormats
        .asMap()
        .map((index, dateFormat) => MapEntry(
              index,
              SettingsTile(
                title: Text(dateFormat),
                onPressed: (BuildContext context) {
                  viewModel.selectDateFormat(index);
                },
                trailing: viewModel.selectedDateFormatIndex == index
                    ? Icon(Icons.check, color: Colors.blue)
                    : null,
              ),
            ))
        .values
        .toList();
  }
}
