import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 80,
          left: 20,
          right: 20,
          bottom: 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/out.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text('Keluar')
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                width: 100,
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/in.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text('Masuk')
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}