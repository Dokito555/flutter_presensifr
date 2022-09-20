import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/profile_response_model.dart';
import 'package:presensifr/provider/login_provider.dart';
import 'package:presensifr/provider/profile_provider.dart';
import 'package:presensifr/util/status_state.dart';
import 'package:presensifr/widgets/title_description.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileResult? _result;

  @override
  Widget build(BuildContext context) {

    // var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    // var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    
    // void _onLoading() {
    //   showDialog(
    //     context: context, 
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return const CircularProgressIndicator();
    //     }
    //   );
    // }

    // Future<void> getProfile() async {
    //   final nik = loginProvider.loginResult.data!.result.nik;
    //   final nip = loginProvider.loginResult.data!.result.nip;

    //   _onLoading();

    //   await ApiService.getProfile(nik, nip);

    //   if (profileProvider.status == Status.failed) {
    //     Fluttertoast.showToast(
    //       msg: 'Gagal Menampilkan Profile',
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1
    //     );
    //   } else if (profileProvider.status == Status.success) {
    //     setState(() {
    //       this._result = profileProvider.profileResult;
    //     });
    //   } else {
    //     Fluttertoast.showToast(
    //       msg: 'Ada kesalahan mohon ulang kembali',
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1
    //     );
    //   }
    // }

    // getProfile();

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    _profileImage(context),
                    _profileInfo(context),
                    _signOut()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImage(BuildContext context) {
    return Column();
  }

  Widget _profileInfo(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, state, _) {
         if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == Status.success) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.person),
                    title: Text("${state.profileResult.data!.result.nama}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.email),
                    title: Text("${state.profileResult.data!.result.email}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.credit_card),
                    title: Text("${state.profileResult.data!.result.nik}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.credit_card),
                    title: Text("${state.profileResult.data!.result.nip}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.phone),
                    title: Text("${state.profileResult.data!.result.noHp}"),
                  ),
                ),
              ],
            ),
          );
        } 
        else if (state.status == Status.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Text('Ada kesalahan');
        }
      },
    );
  }

  Widget _signOut() {
    return Column();
  }
}