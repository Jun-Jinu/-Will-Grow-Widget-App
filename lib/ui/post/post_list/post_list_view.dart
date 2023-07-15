import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:board_widget/ui/widgets/menu_bottom.dart';
import 'package:board_widget/ui/widgets/weather_icon.dart';
import 'package:board_widget/data/model/post/post.dart';
import './post_list_viewmodel.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 일기'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MenuBottom(selectedIndex: 1),
      body: FutureBuilder<List<Post>?>(
        future: Provider.of<PostListViewModel>(context).loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Post> postList = snapshot.data ?? [];

            if (postList.isEmpty) {
              // 리스트가 비어있는 화면일때.
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '아직 일기를 작성하지 않으셨군요!\n당신의 아름다운 오늘을 기록해보세요.',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text('일기쓰러가기'),
                    ),
                  ],
                ),
              );
            } else {
              return _buildPostList(postList, context);
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildPostList(List<Post> postList, BuildContext context) {
    late PostListViewModel viewModel;

    return ListView.builder(
      itemBuilder: (context, index) {
        viewModel = Provider.of<PostListViewModel>(context);
        final post = postList[postList.length - 1 - index];
        final formattedDate =
            "${post.date.year}.${post.date.month}.${post.date.day}";
        viewModel.onCheckWidgetText(post.id);

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
                    leading: WeatherIcon(index: post.weatherIndex),
                    title: Row(
                      children: [
                        if (viewModel.isWidgetText(post.id))
                          Text(
                            "[목표]",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        Text(post.promise),
                      ],
                    ),
                    trailing: Text(formattedDate),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  height: 1.0,
                  color: Colors.grey[300],
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
