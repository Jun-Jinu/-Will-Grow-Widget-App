import '../model/post.dart';
import '../datasource/local_datasource.dart';

class PostRepository {
  late final LocalDataSource _localDataSource;

  /// 로컬에 저장된 일기를 목록가져옴
  Future<List<Post>> getPosts() {
    return _localDataSource.getPosts();
  }
}
