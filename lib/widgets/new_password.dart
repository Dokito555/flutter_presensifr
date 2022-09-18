import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/new_pass_response.dart';
import 'package:presensifr/provider/code_ver_provider.dart';
import 'package:presensifr/provider/new_pass_provider.dart';
import 'package:presensifr/util/status_state.dart';
import 'package:presensifr/widgets/email_verification.dart';
import 'package:provider/provider.dart';

import '../provider/email_ver_provider.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage({
    Key? key, 
  }) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
Map<String, dynamic> newPasswordData = {"password" : null};

class _NewPasswordPageState extends State<NewPasswordPage> {

  NewPasswordResult _newPassResponse = NewPasswordResult();
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
          decoration: const BoxDecoration(
            color: ColorPalette.secondaryColor
          ),
          child: Form(
            key: _addPointKey,
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      _closeIcon(context),
                      _passwordForm(),
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

  Widget _closeIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 60,
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor
      ),
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.close),
        color: ColorPalette.whiteColor,
        onPressed: () {
          Navigator.pushNamed(context, PageRoutes.loginRoute);
        },
      ),
    );
  }

  Widget _passwordForm() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      margin: EdgeInsets.all(20),
      child: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.greyColor, width: 1.5
            )
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black, width: 1.0
            )
          ),
          hintText: "Masukkan password yang baru",
          labelText: "New Password",
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: ColorPalette.greyColor),
          suffixIcon: GestureDetector(
            onTap: () {
              _togglePasswordVisibility();
            },
            child: Icon(
              _isPasswordHide ? Icons.visibility_off : Icons.visibility
            ),
          )
        ),
        style: const TextStyle(color: Colors.black),
        obscureText: _isPasswordHide,
        autofocus: false,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password Harus diisi";
          }
          return null;
        },
        onChanged: (String value) {
          newPasswordData["password"] = value;
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {

    var newPasswordProvider = Provider.of<NewPasswordProvider>(context, listen: false);
    var emailVerificationProvider = Provider.of<EmailVerificationProvider>(context, listen: false);

    Future<void> _updatePassword() async {

      String email = emailVerificationProvider.emailVerificationResult.data!.result.email;
      String newPassword = newPasswordData.values.elementAt(0).toString();

      await newPasswordProvider.postNewPassword(email, newPassword);

      if (newPasswordProvider.status == Status.failed) {
        Fluttertoast.showToast(
          msg: 'Gagal Memperbarui Password',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
      } else if (newPasswordProvider.status == Status.success) {
        Navigator.of(context).pushNamed(PageRoutes.loginRoute);
        Fluttertoast.showToast(
          msg: 'Password Berhasil Diperbarui',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Ada kesalahan mohon ulang kembali',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
      }
    }
    
   return InkWell(
      child: Container(
        padding: const EdgeInsets.all(9.0),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        height: 50,
        child: const Center(
          child: Text(
            'Send Code',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      onTap: () async {
        if (!_addPointKey.currentState!.validate()) {
          return;
        }
        _updatePassword();
      },
    );
  }
}