import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_viewmodel.dart';
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
        final formattedDate =
            "${item.date.year}.${item.date.month}.${item.date.day}";
        final formattedEndDate =
            "${item.promiseEndDate.month}월 ${item.promiseEndDate.day}일까지 다짐";

        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/post/detail');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  child: ListTile(
                    title: Text(item.promise),
                    subtitle: Text(formattedDate),
                    trailing: Text(formattedEndDate),
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: postList.length,
    );
  }
}
