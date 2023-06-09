import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import './post_edit_viewmodel.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:board_widget/data/model/post.dart';

class PostEditView extends StatefulWidget {
  const PostEditView({Key? key}) : super(key: key);

  @override
  _PostEidtViewState createState() => _PostEidtViewState();
}

class _PostEidtViewState extends State<PostEditView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _promiseController = TextEditingController();
  final TextEditingController _promiseDateController = TextEditingController();

  late PostEditViewModel viewModel;

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
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;

    void editPost() async {
      var box = await Hive.openBox<Post>('postbox');

      // 해당 id의 post를 업데이트해서 넣음
      box.put(
        post.id,
        Post(
          id: post.id,
          content: _contentController.text,
          promise: _promiseController.text,
          date: selectedDay,
          promiseEndDate: selectedDay.add(Duration(days: promiseDuration)),
        ),
      );
    }

    viewModel = Provider.of<PostEditViewModel>(context);

    String formattedDate = DateFormat('yyyy.MM.dd').format(selectedDay);

    _contentController.text = post.content;
    _promiseController.text = post.promise;
    _promiseDateController.text =
        (post.promiseEndDate.difference(DateTime.now()).inDays + 1).toString();
    selectedDay = post.date;

    return Scaffold(
      appBar: AppBar(
        title: Text('수정하기'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: toggleCalendar,
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
                duration: Duration(milliseconds: 150),
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
                  hintText: "다짐",
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
                  Container(
                    width: 80,
                    height: 40,
                    margin: EdgeInsets.only(left: 4.0, right: 5.0),
                    child: TextField(
                      controller: _promiseDateController,
                      maxLines: 1,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: TextStyle(height: 1.0),
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
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      editPost();
                      // TODO: 화면 애니메이션이나 알림 추가
                      Navigator.pushNamed(context, '/post');
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
                      '수정하기',
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
