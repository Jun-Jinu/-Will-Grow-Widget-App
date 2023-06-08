import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (int index) {
        if (index >= 0 && index < routes.length && _selectedIndex != index) {
          Navigator.pushNamed(context, routes[index]);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: '일기 쓰기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: '나의 일기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ],
    );
  }
}
