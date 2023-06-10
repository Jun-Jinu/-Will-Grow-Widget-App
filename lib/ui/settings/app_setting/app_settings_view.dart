import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import './app_settings_viewmodel.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
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
          tiles: buildBackgroundTiles(),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('폰트'),
          tiles: buildFontTiles(),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('글자 크기'),
          tiles: buildFontSizeTiles(),
        ),
        SettingsSection(
          margin: EdgeInsetsDirectional.only(bottom: 20.0),
          title: const Text('날짜 형식'),
          tiles: buildDateFormatTiles(),
        ),
      ],
    );
  }

  List<SettingsTile> buildBackgroundTiles() {
    final viewModel = Provider.of<AppSettingsViewModel>(context);
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

  List<SettingsTile> buildFontTiles() {
    final viewModel = Provider.of<AppSettingsViewModel>(context);
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

  List<SettingsTile> buildFontSizeTiles() {
    final viewModel = Provider.of<AppSettingsViewModel>(context);
    return viewModel.fontSizes
        .asMap()
        .map((index, fontSize) => MapEntry(
              index,
              SettingsTile(
                title: Text(fontSize),
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

  List<SettingsTile> buildDateFormatTiles() {
    final viewModel = Provider.of<AppSettingsViewModel>(context);
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
