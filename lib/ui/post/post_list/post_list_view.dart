import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';
import 'package:board_widget/data/model/post.dart';
import './post_list_viewmodel.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기')),
      bottomNavigationBar: MenuBottom(selectedIndex: 1),
      body: FutureBuilder<List<Post>?>(
        future: Provider.of<PostListViewModel>(context).loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Post> postList = snapshot.data ?? [];
            return _buildPostList(postList, context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPostList(List<Post> postList, BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final post = postList[index];
        final formattedDate =
            "${post.date.year}.${post.date.month}.${post.date.day}";
        final formattedEndDate =
            "${post.promiseEndDate.month}월 ${post.promiseEndDate.day}일까지 다짐";

        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/post/detail', arguments: post.id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  child: ListTile(
                    title: Text(post.promise),
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
