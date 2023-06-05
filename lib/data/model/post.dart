import 'dart:convert';

class Post {
  final String title;
  final String content;
  final String summary;
  final DateTime summaryEndDate;
  final DateTime date;

  Post({
    required this.title,
    required this.content,
    required this.summary,
    required this.summaryEndDate,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      content: json['content'],
      summary: json['summary'],
      summaryEndDate: DateTime.parse(json['summaryEndDate']),
      date: DateTime.parse(json['date']),
    );
  }
}
