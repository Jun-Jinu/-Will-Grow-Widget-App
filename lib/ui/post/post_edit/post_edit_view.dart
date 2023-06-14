import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:board_widget/data/model/post/post.dart';

import './post_edit_viewmodel.dart';

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
    final Post post = ModalRoute.of(context)!.settings.arguments as Post;

    viewModel = Provider.of<PostEditViewModel>(context);
    viewModel.setPost(post);

    return Scaffold(
      appBar: AppBar(
        title: Text('일기 수정하기'),
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
                    margin: EdgeInsets.only(right: 5.0),
                    child: TextField(
                      controller: viewModel.durationController,
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
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () async {
                      await viewModel.editPost(context);
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
                      '수정하기',
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
