import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/profile_response_model.dart';
import 'package:presensifr/provider/login_provider.dart';
import 'package:presensifr/provider/logout_provider.dart';
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
                    _signOut(context)
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
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        if (profileProvider.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileProvider.status == Status.success) {
          return Container(
            margin: EdgeInsets.only(top: 40),
            height: 130,
            width: 130,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipOval(
                    child: Image.network(
                     "http://${profileProvider.profileResult.data!.result.image}",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primaryColor
                      ),
                      child: const Center(
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      height: 30,
                      width: 30,
                    ),
                    onTap: () {
                      print(profileProvider.profileResult.data!.result.image);
                    },
                  )
                )
              ],
            ),
          );
        } else if (profileProvider.status == Status.error) {
          return Center(
            child: Material(
              child: Text(profileProvider.message),
            ),
          );
        } else if (profileProvider.status == Status.failed) {
          return Center(
            child: Material(
              child: Text(profileProvider.message),
            ),
          );
        } else {
          return const Text('Ada Kesalahan');
        }
      },
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
         if (profileProvider.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (profileProvider.status == Status.success) {
          return Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.person),
                    title: Text("${profileProvider.profileResult.data!.result.nama}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.email),
                    title: Text("${profileProvider.profileResult.data!.result.email}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.credit_card),
                    title: Text("${profileProvider.profileResult.data!.result.nik}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.credit_card),
                    title: Text("${profileProvider.profileResult.data!.result.nip}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 30),
                    iconColor: ColorPalette.primaryColor,
                    leading: const Icon(Icons.phone),
                    title: Text("${profileProvider.profileResult.data!.result.noHp}"),
                  ),
                ),
              ],
            ),
          );
        } 
        else if (profileProvider.status == Status.failed) {
          return Center(
            child: Material(
              child: Text(profileProvider.message),
            ),
          );
        } else if (profileProvider.status == Status.error) {
          return Center(
            child: Material(
              child: Text(profileProvider.message),
            ),
          );
        } else {
          return const Text('Ada kesalahan');
        }
      },
    );
  }

  Widget _signOut(BuildContext context) {

    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var logoutProvider = Provider.of<LogoutProvider>(context, listen: false);

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

    Future<void> _logout() async {

      final nik = loginProvider.loginResult.data!.result.nik;
      final nip = loginProvider.loginResult.data!.result.nip;

      _onLoading();

      await logoutProvider.logout(nik, nip);

      if (loginProvider.status == Status.failed) {
        Fluttertoast.showToast(
          msg: 'Gagal Logout',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
        );
        Navigator.pop(context);
      } else if (loginProvider.status == Status.success) {
        Navigator.pop(context);
        Navigator.pushNamed(context, PageRoutes.loginRoute);
        Fluttertoast.showToast(
          msg: 'Logged out',
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
        Navigator.pop(context);
      }

    }

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20.0)),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(9.0),
            width: 160,
            height: 50,
            child: const Center(
              child: Text(
                "Logout",
                style: TextStyle(color: ColorPalette.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor,
            borderRadius: BorderRadius.circular(10.0)),
          ),
          onTap: () async {
            _logout();
          }
        ),
      ],
    );
  }
}