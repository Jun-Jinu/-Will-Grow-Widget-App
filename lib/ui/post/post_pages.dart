import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './post_view.dart';
import './post_viewmodel.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostListViewModel>(
        create: (_) => PostListViewModel(), child: PostListView());
  }
}
