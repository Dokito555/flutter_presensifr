import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/code_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';

class CodeVerification extends StatefulWidget {
  CodeVerification({
    Key? key, 
  }) : super(key: key);

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {

  CodeVerResponse _codeVerResponse = CodeVerResponse();

  @override
  Widget build(BuildContext context) {

    final EmailVerResponse emailVerResponse = ModalRoute.of(context)!.settings.arguments as EmailVerResponse;

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

  Widget _codeVerification(BuildContext context, EmailVerResponse emailVerResponse) {

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

                  ApiService.codeVer(
                    emailVerResponse.data!.result.code1, 
                    emailVerResponse.data!.result.email
                  ).then((value) {

                    setState(() {
                      _codeVerResponse = value;
                    });
                    if (_codeVerResponse.errCode != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal Verifikasi'))
                      );
                    } else {
                      Navigator.pushNamed(context, PageRoutes.newPasswordRoute, arguments: emailVerResponse);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil, Silahkan Memperbarui Password'))
                      );
                    }

                  });
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

                  ApiService.codeVer(
                    emailVerResponse.data!.result.code2, 
                    emailVerResponse.data!.result.email
                  ).then((value) {

                    setState(() {
                      _codeVerResponse = value;
                    });
                    if (_codeVerResponse.errCode != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal Verifikasi'))
                      );
                    } else {
                      Navigator.pushNamed(context, PageRoutes.newPasswordRoute, arguments: emailVerResponse);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil, Silahkan Memperbarui Password'))
                      );
                    }

                  });
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

                  ApiService.codeVer(
                    emailVerResponse.data!.result.code3, 
                    emailVerResponse.data!.result.email
                  ).then((value) {

                    setState(() {
                      _codeVerResponse = value;
                    });
                    if (_codeVerResponse.errCode != 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kode Yang Anda Pilih Salah Silahkan Coba Lagi'))
                      );
                    } else {
                      Navigator.pushNamed(context, PageRoutes.newPasswordRoute, arguments: emailVerResponse);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil, Silahkan Memperbarui Password'))
                      );
                    }

                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}