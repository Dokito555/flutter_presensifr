import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/screens/login_view.dart';
import 'package:presensifr/widgets/code_verification.dart';

class EmailVerificationSheet extends StatefulWidget {
  EmailVerificationSheet({Key? key}) : super(key: key);

  @override
  State<EmailVerificationSheet> createState() => _EmailVerificationSheetState();
}

final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
Map<String, dynamic> emaildata = {"email" : null};

class _EmailVerificationSheetState extends State<EmailVerificationSheet> {

  EmailVerResponse _emailVerResponse = EmailVerResponse();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  _emailForm(),
                  _buildButton(context)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _closeIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 60,
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor,
      ),
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.close),
        color: ColorPalette.whiteColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _emailForm() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      margin: EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.greyColor, width: 1.5
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black, width: 1.0
            )
          ),
          hintText: "Masukkan Email",
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: ColorPalette.greyColor)
        ),
        style: const TextStyle(color: Colors.black),
        autofocus: false,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email harus diisi";
          }
          return null;
        },
        onChanged: (String value) {
          emaildata["email"] = value;
        },
        onSaved: (String? value) {
          emaildata["email"] = value;
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
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

        String email = emaildata.values.elementAt(0).toString();

        ApiService.emailVer(email).then(
          (value) {
            setState(() {
              _emailVerResponse = value;
            });
            if (_emailVerResponse.errCode != 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal Kirim'))
              );
            } else {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.codeVerificationRoute, arguments: _emailVerResponse);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kode Berhasil Terkirim'))
              );
            }
          }
        );
      },
    );
  }
}