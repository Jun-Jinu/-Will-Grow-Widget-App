import '../model/post.dart';
import 'package:hive/hive.dart';

class LocalDataSource {
  /// 캐싱한 일기를 가져옴
  Future<List<Post>> getPosts() async {
    var postBox = Hive.box<Post>('postBox');
    return postBox.values.toList();
  }

  /// ID로 특정 일기를 가져옴
  Future<Post> getPostById(int id) async {
    var postBox = Hive.box<Post>('postBox');
    var post = postBox.get(id);

    if (post == null) {
      throw Exception('일기를 찾을 수 없습니다.'); // 예외 처리
    }
    return post;
  }

  /// ID로 특정 일기를 삭제함
  Future<void> deletePostById(int id) async {
    var postBox = Hive.box<Post>('postBox');
    await postBox.delete(id);
  }

  /// 일기를 수정함
  Future<void> updatePost(Post updatedPost) async {
    var postBox = Hive.box<Post>('postBox');
    await postBox.put(updatedPost.id, updatedPost);
  }

  /// 일기를 추가함
  Future<void> addPost(Post newPost) async {
    var postBox = Hive.box<Post>('postBox');

    // post의 index만 기록하는 LOCAL STORAGE
    var postIndexBox = Hive.box<int>('postIndexBox');
    int currentCounter = postIndexBox.isEmpty ? 1 : postIndexBox.getAt(0)!;

    // id를 1씩 올리면서 부여(삭제할 경우 비는 id가 됨)
    newPost.id = currentCounter++;

    // 새로운 일기 추가
    await postBox.add(newPost);
  }
}
