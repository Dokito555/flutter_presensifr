import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/provider/login_provider.dart';
import 'package:presensifr/provider/profile_provider.dart';
import 'package:presensifr/screens/attendance_view.dart';
import 'package:presensifr/screens/history_view.dart';
import 'package:presensifr/screens/profile_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {

    var loginProvider = Provider.of<LoginProvider>(context);

    final List<Widget> _navbarPages = [
      const AttendancePage(),
      const HistoryPage(),
      ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(
          nik: loginProvider.loginResult.data!.result.nik, 
          nip: loginProvider.loginResult.data!.result.nip
        ),
        child: ProfilePage(),
      )
    ];

    final List<String> _navbarTitle = [
      "Attendance",
      "History",
      "Profile"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_navbarTitle[_currentNavIndex]),
        backgroundColor: ColorPalette.primaryColor,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _navbarPages[_currentNavIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorPalette.primaryColor,
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