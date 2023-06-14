import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post {
  Post({
    required this.id,
    required this.weatherIndex,
    required this.content,
    required this.promise,
    required this.date,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  int weatherIndex;

  @HiveField(2)
  String content;

  @HiveField(3)
  String promise;

  @HiveField(4)
  DateTime date;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      weatherIndex: json['weatherIndex'],
      content: json['content'],
      promise: json['promise'],
      date: DateTime.parse(json['date']),
    );
  }
}

// flutter packages pub run build_runner build
// 로 해당 모델의 g.dart파일 생성