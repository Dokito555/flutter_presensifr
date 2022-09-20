import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/code_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/provider/code_ver_provider.dart';
import 'package:presensifr/provider/email_ver_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        toolbarHeight: 10,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
          color: ColorPalette.primaryColor
          ),
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    _closeIcon(context),
                    _codeVerification(context),
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

  Widget _codeVerification(BuildContext context) {

    var codeVerificationProvider = Provider.of<CodeVerificationProvider>(context);
    var emailVerificationProvider = Provider.of<EmailVerificationProvider>(context);
    final code1 = emailVerificationProvider.emailVerificationResult.data!.result.code1;
    final code2 = emailVerificationProvider.emailVerificationResult.data!.result.code2;
    final code3 = emailVerificationProvider.emailVerificationResult.data!.result.code3;

    void _onLoading() {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );
    }

    Future<void> _codeVerify(int code) async {

      final email = emailVerificationProvider.emailVerificationResult.data!.result.email;

      await codeVerificationProvider.codeVerify(code, email);

      _onLoading();

      if (codeVerificationProvider.status == Status.failed) {
        Navigator.pushNamed(context, PageRoutes.loginRoute);
        Fluttertoast.showToast(
          msg: 'Gagal verifikasi mohon ulang kembali',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1
        );
      } else if (codeVerificationProvider.status == Status.verified) {
        Navigator.pushNamed(context, PageRoutes.newPasswordRoute);
        Fluttertoast.showToast(
          msg: 'Berhasil, Silahkan Memperbarui Password',
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

    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${code1}'),
                onPressed: () async {
                  _codeVerify(code1);
                },
              ),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${code2}'),
                onPressed: () async {
                  _codeVerify(code2);
                },
              ),
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: TextButton(
                child: Text('${code3}'),
                onPressed: () async {
                  _codeVerify(code3);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}