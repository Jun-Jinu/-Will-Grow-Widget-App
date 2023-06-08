class Post {
  final int id;
  final String content;
  final String promise;
  final DateTime promiseEndDate;
  final DateTime date;

  Post({
    required this.id,
    required this.content,
    required this.promise,
    required this.promiseEndDate,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      date: DateTime.parse(json['date']),
      content: json['content'],
      promise: json['promise'],
      promiseEndDate: DateTime.parse(json['promiseEndDate']),
    );
  }
}
