import 'package:flutter/material.dart';
import 'package:presensifr/screens/attendance_view.dart';
import 'package:presensifr/screens/history_view.dart';
import 'package:presensifr/screens/profile_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentNavIndex = 0;
  final List<Widget> _navbarPages = [
    const AttendancePage(),
    const HistoryPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _navbarPages[_currentNavIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: 'History'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Profile'
          )
        ],
        onTap: (selected) {
          setState(() {
            _currentNavIndex = selected;
          });
        },
      ),
    );
  }
}