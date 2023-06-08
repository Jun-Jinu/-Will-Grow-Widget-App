import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './post_viewmodel.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:board_widget/data/model/post.dart';

class PostListView extends StatelessWidget {
  late PostListViewModel viewModel;

  PostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<PostListViewModel>(context);

    viewModel.setSelectedIndex(1);

    return Scaffold(
      appBar: AppBar(title: const Text('일기')),
      bottomNavigationBar: MenuBottom(selectedIndex: 1),
      body: FutureBuilder(
        future: Hive.openBox<Post>('postbox'),
        builder: (context, AsyncSnapshot<Box<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final box = snapshot.data;
            if (box != null) {
              final postList = box.values.toList();
              return _buildPostList(postList);
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPostList(List<Post> postList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = postList[index];
        return ListTile(title: Text(item.promise));
      },
      itemCount: postList.length,
    );
  }
}
