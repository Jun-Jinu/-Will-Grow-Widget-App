// post_emotion_widget.dart 파일 생성
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PostEmotionWidget extends StatelessWidget {
  final int themeNumber;
  final int selectedIndex;
  final Function(int) onChangeWeather;

  const PostEmotionWidget({
    required this.themeNumber,
    required this.selectedIndex,
    required this.onChangeWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "오늘 내 기분의 날씨는",
          style: TextStyle(fontSize: 32.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                selectedIndex == 0
                    ? CupertinoIcons.flame_fill
                    : CupertinoIcons.flame,
              ),
              color: selectedIndex == 0 ? Colors.deepOrange : null,
              onPressed: () => onChangeWeather(0),
            ),
            IconButton(
              icon: Icon(
                selectedIndex == 1
                    ? CupertinoIcons.sun_max_fill
                    : CupertinoIcons.sun_min,
              ),
              color: selectedIndex == 1 ? Colors.orange : null,
              onPressed: () => onChangeWeather(1),
            ),
            IconButton(
              icon: Icon(
                selectedIndex == 2
                    ? CupertinoIcons.cloud_sun_fill
                    : CupertinoIcons.cloud_sun,
              ),
              color: selectedIndex == 2 ? Colors.lightBlue : null,
              onPressed: () => onChangeWeather(2),
            ),
            IconButton(
              icon: Icon(
                selectedIndex == 3
                    ? CupertinoIcons.cloud_rain_fill
                    : CupertinoIcons.cloud_rain,
              ),
              color: selectedIndex == 3 ? Colors.blueGrey : null,
              onPressed: () => onChangeWeather(3),
            ),
            IconButton(
              icon: Icon(
                selectedIndex == 4
                    ? CupertinoIcons.moon_stars_fill
                    : CupertinoIcons.moon_stars,
              ),
              color: selectedIndex == 4 ? Colors.amber : null,
              onPressed: () => onChangeWeather(4),
            ),
          ],
        ),
      ],
    );
  }
}
