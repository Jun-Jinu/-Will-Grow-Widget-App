import '../model/post/post.dart';
import '../model/home_widget/home_widget.dart';
import '../datasource/local_datasource.dart';

class PostRepository {
  late final LocalDataSource _localDataSource;

  PostRepository() {
    _localDataSource = LocalDataSource();
  }

  /// 로컬에 저장된 일기 목록을 가져옴
  Future<List<Post>> getPosts() {
    return _localDataSource.getPosts();
  }

  /// 로컬에 저장된 특정 ID의 일기를 가져옴
  Future<Post> getPostById(int id) {
    return _localDataSource.getPostById(id);
  }

  /// 특정 ID의 일기를 삭제함
  Future<void> deletePostById(int id) {
    return _localDataSource.deletePostById(id);
  }

  /// 일기를 수정함
  Future<void> updatePost(Post updatedPost) {
    return _localDataSource.updatePost(updatedPost);
  }

  /// 일기를 추가함
  Future<int> addPost(Post newPost) {
    return _localDataSource.addPost(newPost);
  }

  // 대표 일기를 변경함
  Future<void> updateWidgetText(HomeWidget homeWidget) {
    return _localDataSource.updateWidgetText(homeWidget);
  }
}
