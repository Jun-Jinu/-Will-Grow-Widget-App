import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './new_post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatelessWidget {
  NewPostView({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _promiseController = TextEditingController();
  late NewPostViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 일기'),
      ),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                ),
                hintText: "제목(필수)",
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
                hintText: "일기(선택)",
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
                hintText: "오늘의 다짐(필수)",
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
                Expanded(
                  flex: 3,
                  child: Text(
                    '얼마만에 이뤄볼까요?',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '일',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
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
                    'Save',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
