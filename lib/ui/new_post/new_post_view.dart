import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:getwidget/getwidget.dart';

import './new_post_viewmodel.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  _NewPostViewState createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView>
    with SingleTickerProviderStateMixin {
  late NewPostViewModel viewModel;

  // TODO: viewModel로 옮길경우 여러번 호출 문제 해결
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('일기 쓰기'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 0,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: viewModel.onToggleCalendar,
                  child: Container(
                    width: 300,
                    height: 60.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      viewModel.formattedDate,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                AnimatedContainer(
                  height: viewModel.showCalendar ? 400 : 0,
                  duration: Duration(milliseconds: 250),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TableCalendar(
                          locale: 'ko-KR',
                          firstDay: DateTime.utc(2021, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: viewModel.focusedDay,
                          selectedDayPredicate: (DateTime day) {
                            return isSameDay(viewModel.selectedDay, day);
                          },
                          calendarStyle: CalendarStyle(
                            selectedDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            todayDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            dowBuilder: (context, day) {
                              return Center(
                                  child: Text(viewModel.days[day.weekday]));
                            },
                          ),
                          onDaySelected: viewModel.onDaySelected,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: viewModel.onPressdConfirm,
                              child: Text(
                                '확인',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "오늘 내 기분의 날씨는",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        viewModel.selectedIndex == 0
                            ? CupertinoIcons.flame_fill
                            : CupertinoIcons.flame,
                      ),
                      color: viewModel.selectedIndex == 0
                          ? Colors.deepOrange
                          : null,
                      onPressed: () => viewModel.onChangeWeather(0),
                    ),
                    IconButton(
                      icon: Icon(
                        viewModel.selectedIndex == 1
                            ? CupertinoIcons.sun_max_fill
                            : CupertinoIcons.sun_min,
                      ),
                      color:
                          viewModel.selectedIndex == 1 ? Colors.orange : null,
                      onPressed: () => viewModel.onChangeWeather(1),
                    ),
                    IconButton(
                      icon: Icon(
                        viewModel.selectedIndex == 2
                            ? CupertinoIcons.cloud_sun_fill
                            : CupertinoIcons.cloud_sun,
                      ),
                      color: viewModel.selectedIndex == 2
                          ? Colors.lightBlue
                          : null,
                      onPressed: () => viewModel.onChangeWeather(2),
                    ),
                    IconButton(
                      icon: Icon(
                        viewModel.selectedIndex == 3
                            ? CupertinoIcons.cloud_rain_fill
                            : CupertinoIcons.cloud_rain,
                      ),
                      color:
                          viewModel.selectedIndex == 3 ? Colors.blueGrey : null,
                      onPressed: () => viewModel.onChangeWeather(3),
                    ),
                    IconButton(
                      icon: Icon(
                        viewModel.selectedIndex == 4
                            ? CupertinoIcons.moon_stars_fill
                            : CupertinoIcons.moon_stars,
                      ),
                      color: viewModel.selectedIndex == 4 ? Colors.amber : null,
                      onPressed: () => viewModel.onChangeWeather(4),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: "일기",
                    errorStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  maxLines: 10,
                  validator: viewModel.validateContent,
                  onSaved: viewModel.onSavedContent,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: "오늘의 다짐",
                    errorStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  validator: viewModel.validatePromise,
                  onSaved: viewModel.onSavedPromise,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: viewModel.toggleCheckbox,
                  child: Row(
                    children: [
                      GFCheckbox(
                        customBgColor: Theme.of(context).colorScheme.secondary,
                        size: GFSize.SMALL,
                        type: GFCheckboxType.custom,
                        onChanged: viewModel.onCheckboxChanged,
                        value: viewModel.isCheckedWidgetText,
                        inactiveIcon: null,
                      ),
                      Container(
                        child: Text(
                          '나의 주요 목표로 설정합니다.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    '홈화면 위젯을 추가해서 목표를 이뤄보세요!',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          await viewModel.savePost(context);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        '기록하기',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
