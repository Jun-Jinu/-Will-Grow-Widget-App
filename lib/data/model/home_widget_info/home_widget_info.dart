import 'package:hive/hive.dart';

part 'home_widget_info.g.dart';

@HiveType(typeId: 5)
class HomeWidgetInfo {
  HomeWidgetInfo({
    required this.postId,
    required this.homeWidgetText,
  });

  @HiveField(0)
  int postId;

  @HiveField(1)
  String homeWidgetText;

  factory HomeWidgetInfo.fromJson(Map<String, dynamic> json) {
    return HomeWidgetInfo(
      postId: json['postId'],
      homeWidgetText: json['homeWidgetText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "homeWidgetText": homeWidgetText,
    };
  }
}
