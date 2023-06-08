import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import './new_post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatefulWidget {
  NewPostView({Key? key}) : super(key: key);

  @override
  _NewPostViewState createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _promiseController = TextEditingController();
  late NewPostViewModel viewModel;

  final int promiseDuration = 1;
  bool onDirect = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    DateTime selectedDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    DateTime focusedDay = DateTime.now();
    List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 일기'),
      ),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TableCalendar(
                // locale: 'ko_KR',
                firstDay: DateTime.utc(2021, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신합니다.
                  setState(() {
                    selectedDay = selectedDay;
                    focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                  return isSameDay(selectedDay, day);
                },
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    return Center(child: Text(days[day.weekday]));
                  },
                ),
              ),
              TextField(
                controller: _contentController,
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
                controller: _promiseController,
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
              Row(
                children: [
                  SizedBox(width: 8.0),
                  Container(
                    width: 100,
                    child: DropdownButtonFormField<int>(
                      value: promiseDuration,
                      alignment: AlignmentDirectional.centerEnd,
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Center(child: Text('1')),
                        ),
                        DropdownMenuItem<int>(
                          value: 7,
                          child: Center(child: Text('7')),
                        ),
                        DropdownMenuItem<int>(
                          value: 30,
                          child: Center(child: Text('30')),
                        ),
                        DropdownMenuItem<int>(
                          value: -2,
                          child: Center(child: Text('무제한')),
                        ),
                        DropdownMenuItem<int>(
                          value: -3,
                          child: Center(child: Text('직접입력')),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          value == -3 ? onDirect = true : onDirect = false;
                        });
                      },
                    ),
                  ),
                  if (onDirect)
                    Container(
                      width: 80,
                      height: 40,
                      margin: EdgeInsets.only(left: 30.0, right: 5.0),
                      child: TextField(
                        maxLines: 1,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  Container(
                    width: 120,
                    child: Text(
                      '일의 다짐',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0), // 추가: 달력 아래에 여백을 줍니다.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.lightBlue,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '기록하기',
                      style: TextStyle(fontSize: 20),
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
