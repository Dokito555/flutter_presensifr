import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/login_model.dart';
import 'package:presensifr/data/model/response_model/login_response_model.dart';
import 'package:presensifr/provider/login_provider.dart';
import 'package:presensifr/server.dart';
import 'package:presensifr/util/status_state.dart';
import 'package:presensifr/widgets/title_description.dart';
import 'package:provider/provider.dart';

import '../widgets/email_verification.dart';

final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
Map<String, dynamic> formData = {
  "email": null,
  "password": null
};

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginPage> {
  bool _isPasswordHide = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHide = !_isPasswordHide;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorPalette.primaryColor,
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _addPointKey,
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      _iconLogin(),
                      TitleDescription(
                        title: "Login to PresensiFR", 
                        subTitle: "Gunakan Username dan Password yang sudah terdaftar"
                      ),
                      _formLogin(),
                      _buildButton(context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconLogin() {
    return Image.asset(
      "assets/images/icon_login.png",
      width: 150.0,
      height: 150.0,
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 16.0)),
        // Username
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.underlineTextField, width: 1.5)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3.0)),
              hintText: "Masukkan Email",
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: ColorPalette.hintColor)),
          style: const TextStyle(color: Colors.white),
          autofocus: false,
          validator: (value) {
            if (value!.isEmpty) {
              return "Email harus diisi";
            }
            return null;
          },
          onChanged: (String value) {
            formData["email"] = value;
          },
          onSaved: (String? value) {
            formData["email"] = value;
          },
        ),
        // Password
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorPalette.underlineTextField, width: 1.5)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            hintText: "Masukkan Password",
            labelText: "Password",
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle: const TextStyle(color: ColorPalette.hintColor),
            suffixIcon: GestureDetector(
              onTap: () {
                _togglePasswordVisibility();
              },
              child: Icon(
                  _isPasswordHide ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: _isPasswordHide,
          autofocus: false,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value!.isEmpty) {
              return "Password harus diisi";
            }
            return null;
          },
          onChanged: (String value) {
            formData["password"] = value;
          },
          onSaved: (String? value) {
            formData["password"] = value;
          },
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {

    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    Future<void> _login() async {

      String email = formData.values.elementAt(0).toString();
      String password = formData.values.elementAt(1).toString();

      LoginModel loginData = LoginModel(
        email: email, 
        password: password
      );

      await loginProvider.postLogin(loginData);

      if (loginProvider.status == Status.failed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal Login'))
        );
      } else if (loginProvider.status == Status.success) {
        Navigator.pushNamed(context, PageRoutes.homeRoute);
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Berhasil Login'))
        );
      }

    }

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 40.0)),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(9.0),
            width: double.infinity,
            child: const Text(
              "Login",
              style: TextStyle(color: ColorPalette.primaryColor),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0)),
            ),
            onTap: () async {
              if (!_addPointKey.currentState!.validate()) {
                return;
              }
              _login();
            }),

            const SizedBox(
              height: 24,
            ),

            InkWell(
              child: Container(
                padding: const EdgeInsets.all(9.0),
                width: double.infinity,
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: ColorPalette.primaryColor),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.signupRoute);
              },
            ),

            const SizedBox(
              height: 20,
            ),

            TextButton(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: ColorPalette.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => {
                showModalBottomSheet(
                  context: context, 
                  builder: (context) => EmailVerificationSheet()
                )
              },
            )
      ],
    );
  }
}