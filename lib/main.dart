//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:presensifr/screens/login_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PresensiFR',
    initialRoute: "/",
    routes: {"/": (context) => LoginPage()},
  ));
}
