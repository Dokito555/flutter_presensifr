//import 'dart:js';

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/provider/code_ver_provider.dart';
import 'package:presensifr/provider/email_ver_provider.dart';
import 'package:presensifr/provider/image_picker_provider.dart';
import 'package:presensifr/provider/login_provider.dart';
import 'package:presensifr/provider/new_pass_provider.dart';
import 'package:presensifr/screens/home_view.dart';
import 'package:presensifr/screens/login_view.dart';
import 'package:presensifr/screens/signup_view.dart';
import 'package:presensifr/widgets/code_verification.dart';
import 'package:presensifr/widgets/new_password.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => EmailVerificationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CodeVerificationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => NewPasswordProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ImagePickerProvider(),
      )
    ],
      child: const App(),
    )
  );
}

class App extends StatelessWidget {

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PresensiFR',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
      ),
      initialRoute: PageRoutes.loginRoute,
      routes: {
        PageRoutes.loginRoute: (context) => LoginPage(),
        PageRoutes.signupRoute: (context) => SignupPage(),
        PageRoutes.codeVerificationRoute: (context) => CodeVerification(),
        PageRoutes.newPasswordRoute: (context) => NewPasswordPage(),
        PageRoutes.homeRoute: (context) => HomePage()
      },
    );
  }
}

