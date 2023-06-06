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
  void didUpdateWidget(covariant MenuBottom oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/newpost');
            break;
          case 2:
            Navigator.pushNamed(context, '/settings');
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: 'Write Diary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Preferences',
        ),
      ],
    );
  }
}
