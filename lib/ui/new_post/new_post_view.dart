import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/data/repository/post_repository.dart';

import './new_post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class NewPostView extends StatelessWidget {
  NewPostView({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late NewPostViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<NewPostViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
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
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;

                // Validate the inputs, e.g., check if title and content are not empty

                // Call the postRepository to save the new post
                // postRepository.savePost(title, content);

                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
