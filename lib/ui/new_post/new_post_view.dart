import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:getwidget/getwidget.dart';

import './new_post_viewmodel.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  _NewPostView createState() => _NewPostView();
}

class _NewPostView extends State<NewPostView>
    with SingleTickerProviderStateMixin {
  late NewPostViewModel viewModel;

  int selectedIndex = -1;
  bool isChecked = false; // 체크박스의 초기 상태

// 체크박스의 상태 변경 시 호출되는 콜백 함수
  void onCheckboxChanged(bool value) {
    setState(() {
      isChecked = value; // 체크박스의 상태 변경
    });
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: viewModel.toggleCalendar,
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
                duration: Duration(milliseconds: 300),
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
                            color: Theme.of(context)
                                .primaryColor, // 주요 색상을 primary 색상으로 사용
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color:
                                Theme.of(context).primaryColor, // 좌측 버튼 색상 설정
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color:
                                Theme.of(context).primaryColor, // 우측 버튼 색상 설정
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
                          // 확인 버튼
                          TextButton(
                            onPressed: viewModel.onConfirmPressed,
                            child: Text(
                              '확인',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context).primaryColor),
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
                  mainAxisAlignment: MainAxisAlignment.center, // 중간 정렬
                  children: [
                    IconButton(
                      icon: Icon(selectedIndex == 3
                          ? CupertinoIcons.flame_fill
                          : CupertinoIcons.flame),
                      color: selectedIndex == 3 ? Colors.amber : null,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(selectedIndex == 0
                          ? CupertinoIcons.sun_max_fill
                          : CupertinoIcons.sun_min),
                      color: selectedIndex == 0 ? Colors.amber : null,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(selectedIndex == 1
                          ? CupertinoIcons.cloud_sun_fill
                          : CupertinoIcons.cloud_sun),
                      color: selectedIndex == 1 ? Colors.amber : null,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(selectedIndex == 2
                          ? CupertinoIcons.cloud_rain_fill
                          : CupertinoIcons.cloud_rain),
                      color: selectedIndex == 2 ? Colors.amber : null,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(selectedIndex == 4
                          ? CupertinoIcons.moon_stars_fill
                          : CupertinoIcons.moon_stars),
                      color: selectedIndex == 4 ? Colors.amber : null,
                      onPressed: () {
                        setState(() {
                          selectedIndex = 4;
                        });
                      },
                    ),
                  ]),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 4.0),
              ),
              TextField(
                controller: viewModel.contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintText: "일기",
                ),
                maxLines: 10,
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 4.0),
              ),
              TextField(
                controller: viewModel.promiseController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintText: "오늘의 다짐",
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
                margin: EdgeInsets.symmetric(vertical: 4.0),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  GFCheckbox(
                    customBgColor: Theme.of(context).primaryColor,
                    size: GFSize.SMALL,
                    type: GFCheckboxType.custom,
                    onChanged: onCheckboxChanged,
                    value: isChecked,
                    inactiveIcon: null,
                  ),
                  Container(
                    child: Text(
                      '해당 다짐을 나의 핵심 목표로 선택합니다.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () async {
                      await viewModel.savePost(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '기록하기',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
