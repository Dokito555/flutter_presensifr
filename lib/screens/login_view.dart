import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presensifr/constants.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/server.dart';

final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
Map<String, dynamic> formData = {"username": null, "password": null};
var mContext;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginPage> {
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Scaffold(
      body: Container(
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
                    _titleDescription(),
                    _formLogin(),
                    _buildButton()
                  ],
                ),
              )
            ],
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

  Widget _titleDescription() {
    return Column(
      children: const [
        Padding(padding: EdgeInsets.only(top: 16.0)),
        Text(
          "Login to PresensiFR",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.only(top: 12.0)),
        Text(
          "Gunakan Username dan Password yang sudah terdaftar",
          style: TextStyle(color: Colors.white, fontSize: 12.0),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 16.0)),
        TextFormField(
          decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.underlineTextField, width: 1.5)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3.0)),
              hintText: "Masukkan Username",
              labelText: "Username",
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: ColorPalette.hintColor)),
          style: const TextStyle(color: Colors.white),
          autofocus: false,
          validator: (value) {
            if (value!.isEmpty) {
              return "Username harus diisi";
            }
            return null;
          },
          onChanged: (String value) {
            formData["username"] = value;
          },
          onSaved: (String? value) {
            formData["username"] = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorPalette.underlineTextField, width: 1.5)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            hintText: "Masukkan Password",
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: ColorPalette.hintColor),
            suffixIcon: GestureDetector(
              onTap: () {
                _togglePasswordVisibility();
              },
              child: Icon(
                  _isHidePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: _isHidePassword,
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

  Widget _buildButton() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 16.0)),
        InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              child: Text(
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

              String username = formData.values.elementAt(0).toString();
              String password = formData.values.elementAt(1).toString();
              const tenant = 'grit';

              final urlLogin = Uri.parse(APIServer.urlLogin);
              final response = await http.post(
                urlLogin,
                headers: <String, String>{
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(<String, String>{
                  'email': username,
                  'password': password,
                  'tenant': tenant
                }),
              );

              print('Response request: ${response.request}');
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              final resp = json.decode(response.body);
              var err_code = resp["err_code"];
              if (err_code == 0) {
                ScaffoldMessenger.of(mContext).showSnackBar(
                    SnackBar(content: Text("Data Berhasil Login")));
              } else {
                ScaffoldMessenger.of(mContext).showSnackBar(
                    SnackBar(content: Text("Data Tidak Berhasil Login")));
              }
            })
      ],
    );
  }
}
