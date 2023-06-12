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
      style: TabStyle.reactCircle,
      onTap: (int index) {
        if (index >= 0 && index < routes.length && _selectedIndex != index) {
          Navigator.pushNamed(context, routes[index]);
        }
      },
      items: const [
        TabItem(
          icon: Icon(Icons.edit),
          title: '일기 쓰기',
        ),
        TabItem(
          icon: Icon(Icons.book_outlined),
          title: '나의 일기',
        ),
        TabItem(
          icon: Icon(Icons.settings),
          title: '설정',
        ),
      ],
    );
  }
}
