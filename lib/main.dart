//import 'dart:js';

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/screens/login_view.dart';
import 'package:presensifr/screens/signup_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PresensiFR',
      initialRoute: PageRoutes.loginRoute,
      routes: {
        PageRoutes.loginRoute: (context) => LoginPage(),
        PageRoutes.signupRoute: (context) => SignupPage(),
      },
    );
  }
}

