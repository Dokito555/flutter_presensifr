import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/code_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/provider/code_ver_provider.dart';
import 'package:presensifr/util/status_state.dart';
import 'package:provider/provider.dart';

class CodeVerification extends StatefulWidget {
  CodeVerification({
    Key? key, 
  }) : super(key: key);

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {

  @override
  Widget build(BuildContext context) {

    final EmailVerificationResult emailVerResponse = ModalRoute.of(context)!.settings.arguments as EmailVerificationResult;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
          color: ColorPalette.secondaryColor
          ),
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    _closeIcon(context),
                    _codeVerification(context, emailVerResponse),
                  ],
                ),
              )
            ],
          )
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

  Widget _codeVerification(BuildContext context, EmailVerificationResult emailVerResponse) {

    var codeVerificationProvider = Provider.of<CodeVerificationProvider>(context);

    Future<void> _codeVerify(int code) async {

      String email = emailVerResponse.data!.result.email;

      await codeVerificationProvider.codeVerify(code, email);

      if (codeVerificationProvider.status == Status.failed) {
        Navigator.pushNamed(context, PageRoutes.loginRoute);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal verifikasi mohon ulang kembali'))
        );
      } else if (codeVerificationProvider.status == Status.verified) {
        Navigator.pushNamed(context, PageRoutes.newPasswordRoute);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil, Silahkan Memperbarui Password'))
        );
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${emailVerResponse.data!.result.code1}'),
                onPressed: () async {
                  _codeVerify(emailVerResponse.data!.result.code1);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${emailVerResponse.data!.result.code2}'),
                onPressed: () async {
                  _codeVerify(emailVerResponse.data!.result.code2);
                },
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${emailVerResponse.data!.result.code3}'),
                onPressed: () async {
                  _codeVerify(emailVerResponse.data!.result.code3);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}