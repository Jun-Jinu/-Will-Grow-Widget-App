import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MenuBottom extends StatefulWidget {
  final int selectedIndex;

  MenuBottom({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _MenuBottomState createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  late int _selectedIndex;
  Color iconColor = Color(0xff333333);
  Color borderColor = Color(0xff666666);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    List<String> routes = [
      '/',
      '/post',
      '/settings',
    ];

    return ConvexAppBar(
      initialActiveIndex: _selectedIndex,
      color: iconColor,
      activeColor: Color(0xbbffffff),
      backgroundColor: Color(0xffecf0f1),
      shadowColor: borderColor,
      style: TabStyle.reactCircle,
      height: 50,
      onTap: (int index) {
        if (index >= 0 && index < routes.length && _selectedIndex != index) {
          Navigator.pushNamed(context, routes[index]);
        }
      },
      items: [
        TabItem(
          icon: Icon(
            Icons.edit,
            color: iconColor,
          ),
          title: '일기 쓰기',
        ),
        TabItem(
          icon: Icon(
            Icons.book_outlined,
            color: iconColor,
          ),
          title: '나의 일기',
        ),
        TabItem(
          icon: Icon(
            Icons.settings,
            color: iconColor,
          ),
          title: '설정',
        ),
      ],
    );
  }
}
