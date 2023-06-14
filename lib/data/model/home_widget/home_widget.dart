import 'package:hive/hive.dart';

part 'home_widget.g.dart';

@HiveType(typeId: 5)
class HomeWidget {
  HomeWidget({
    required this.postId,
    required this.homeWidgetText,
  });

  @HiveField(0)
  int postId;

  @HiveField(1)
  String homeWidgetText;

  factory HomeWidget.fromJson(Map<String, dynamic> json) {
    return HomeWidget(
      postId: json['postId'],
      homeWidgetText: json['homeWidgetText'],
    );
  }
}
