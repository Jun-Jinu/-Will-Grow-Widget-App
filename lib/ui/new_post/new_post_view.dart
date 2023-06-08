import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import './new_post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  _NewPostViewState createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _promiseController = TextEditingController();
  late NewPostViewModel viewModel;

  final int promiseDuration = 1;
  bool onDirect = false;
  bool showCalendar = false;

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  void toggleCalendar() {
    setState(() {
      showCalendar = !showCalendar;
    });
  }

  void onConfirmPressed() {
    toggleCalendar();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    String formattedDate = DateFormat('yyyy.MM.dd').format(selectedDay);

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
              GestureDetector(
                onTap: toggleCalendar, // toggleCalendar 함수로 변경
                child: Container(
                  width: 300,
                  height: 60.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              AnimatedContainer(
                height: showCalendar ? 400 : 0,
                duration: Duration(milliseconds: 400),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2021, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: focusedDay,
                        selectedDayPredicate: (DateTime day) {
                          return isSameDay(selectedDay, day);
                        },
                        calendarBuilders: CalendarBuilders(
                          dowBuilder: (context, day) {
                            return Center(child: Text(days[day.weekday]));
                          },
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            this.selectedDay = selectedDay;
                            this.focusedDay = focusedDay;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // 확인 버튼
                          TextButton(
                            onPressed: onConfirmPressed,
                            child: Text(
                              '확인',
                              style: TextStyle(fontSize: 16.0),
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
                          child: Center(child: Text('1일')),
                        ),
                        DropdownMenuItem<int>(
                          value: 7,
                          child: Center(child: Text('7일')),
                        ),
                        DropdownMenuItem<int>(
                          value: 30,
                          child: Center(child: Text('30일')),
                        ),
                        DropdownMenuItem<int>(
                          value: -2,
                          child: Center(child: Text('평생')),
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
                      '의 다짐',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
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
