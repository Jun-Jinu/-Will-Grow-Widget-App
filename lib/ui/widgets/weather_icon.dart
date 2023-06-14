import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final int index;

  WeatherIcon({required this.index});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color? iconColor;

    switch (index) {
      case 0:
        iconData = CupertinoIcons.flame_fill;
        iconColor = Colors.deepOrange;
        break;
      case 1:
        iconData = CupertinoIcons.sun_max_fill;
        iconColor = Colors.orange;
        break;
      case 2:
        iconData = CupertinoIcons.cloud_sun_fill;
        iconColor = Colors.lightBlue;
        break;
      case 3:
        iconData = CupertinoIcons.cloud_rain_fill;
        iconColor = Colors.blueGrey;
        break;
      case 4:
        iconData = CupertinoIcons.moon_stars_fill;
        iconColor = Colors.amber;
        break;
      default:
        iconData = CupertinoIcons.circle; // 기본 아이콘
    }

    return Icon(
      iconData,
      color: iconColor,
    );
  }
}
