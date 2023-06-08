import 'package:hive/hive.dart';

// class Post {
//   final int id;
//   final String content;
//   final String promise;
//   final DateTime date;
//   final DateTime promiseEndDate;

//   Post({
//     required this.id,
//     required this.content,
//     required this.promise,
//     required this.promiseEndDate,
//     required this.date,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       date: DateTime.parse(json['date']),
//       content: json['content'],
//       promise: json['promise'],
//       promiseEndDate: DateTime.parse(json['promiseEndDate']),
//     );
//   }
// }

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
}
