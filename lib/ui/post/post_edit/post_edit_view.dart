import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import './post_edit_viewmodel.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';

class PostEditView extends StatefulWidget {
  const PostEditView({Key? key}) : super(key: key);

  @override
  _PostEditView createState() => _PostEditView();
}

class _PostEditView extends State<PostEditView>
    with SingleTickerProviderStateMixin {
  late PostEditViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PostEditViewModel>(context);
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
                duration: Duration(milliseconds: 150),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        firstDay: DateTime.utc(2021, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: viewModel.focusedDay,
                        selectedDayPredicate: (DateTime day) {
                          return isSameDay(viewModel.selectedDay, day);
                        },
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
              Row(
                children: [
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
                    onPressed: () async {
                      await viewModel.savePost(context);
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
