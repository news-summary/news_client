import 'package:cubes/cubes.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final callback;

  BottomNavigation(this.callback);

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
          icon: const Icon(Icons.language),
          label: Cubes.getString("tab_recent"),
          backgroundColor: Colors.blue,
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.local_library),
          label: Cubes.getString("tab_news"),
          backgroundColor: Colors.blue[800],
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.info),
          label: Cubes.getString("tab_about"),
          backgroundColor: Colors.blue,
        )
      ],
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          widget.callback(index);
        });
      },
    );

    return botNavBar;
  }
}
