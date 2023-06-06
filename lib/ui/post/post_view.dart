import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './post_viewmodel.dart';

import 'package:board_widget/ui/widgets/menu_bottom.dart';

class PostListView extends StatelessWidget {
  late PostListViewModel viewModel;

  PostListView({super.key});

  @override
  Widget build(BuildContext context) {
    viewModel =
        Provider.of<PostListViewModel>(context); // Provider로 viewModel을 가져온다.

    return Scaffold(
      appBar: AppBar(title: const Text('일기')),
      bottomNavigationBar: MenuBottom(
        selectedIndex: 0,
      ),
      body: _buildPostList(),
    );
  }

  Widget _buildPostList() {
    final items = viewModel.items; // viewModel에 저장된 items
    final itemCount = items.length;
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(title: Text(item.title));
      },
      itemCount: itemCount,
    );
  }
}
