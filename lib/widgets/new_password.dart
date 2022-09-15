import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/new_pass_response.dart';

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

  NewPasswordResponse _newPassResponse = NewPasswordResponse();
  bool _isPasswordHide = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHide = !_isPasswordHide;
    });
  }

  @override
  Widget build(BuildContext context) {

    final EmailVerResponse emailVerResponse = ModalRoute.of(context)!.settings.arguments as EmailVerResponse;

    return Scaffold(
      body: Container(
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
                    _buildButton(context, emailVerResponse)
                  ],
                ),
              )
            ],
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

  Widget _buildButton(BuildContext context, EmailVerResponse emailVerResponse) {
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

        var newPassword = newPasswordData.values.elementAt(0).toString();

        ApiService.updatePass(newPassword, emailVerResponse.data!.result.email).then(
          (value) {
            setState(() {
              _newPassResponse = value;
            });
            if (_newPassResponse.errCode != 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal Memperbarui Password, Mohon Diulang Kembali'))
              );
            } else {
              Navigator.of(context).pushNamed(PageRoutes.loginRoute);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password Berhasil Diperbarui'))
              );
            }
          }
        );
      },
    );
  }
}