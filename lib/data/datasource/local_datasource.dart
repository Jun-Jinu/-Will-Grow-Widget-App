import '../model/post.dart';
import 'package:hive/hive.dart';

class LocalDataSource {
  /// 캐싱한 일기를 가져온다.
  Future<List<Post>> getCachedPosts() async {
    var postBox = Hive.box<Post>('postBox');
    return postBox.values.toList();
  }
}
