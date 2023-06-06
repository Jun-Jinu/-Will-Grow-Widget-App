import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/data/repository/post_repository.dart';

import './new_post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatelessWidget {
  NewPostView({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _promiseController = TextEditingController();
  late NewPostViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('오늘 일기'),
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
                labelText: '제목',
                hintText: "필수사항",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: '일기',
                hintText: "선택사항",
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _promiseController,
              decoration: InputDecoration(
                labelText: '오늘의 다짐',
                hintText: "필수사항",
              ),
            ),

            // TODO: 며칠간 할지 적기! (일 수 입력받는 빈칸 추가)

            SizedBox(height: 32.0),
            SizedBox(
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
                  '저장하기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
