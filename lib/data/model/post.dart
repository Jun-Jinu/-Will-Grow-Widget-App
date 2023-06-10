import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post {
  Post({
    required this.id,
    required this.content,
    required this.promise,
    required this.date,
    required this.promiseEndDate,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String content;

  @HiveField(2)
  String promise;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  DateTime promiseEndDate;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      promise: json['promise'],
      date: DateTime.parse(json['date']),
      promiseEndDate: DateTime.parse(json['promiseEndDate']),
    );
  }
}

// flutter packages pub run build_runner build
// 로 해당 모델의 g.dart파일 생성