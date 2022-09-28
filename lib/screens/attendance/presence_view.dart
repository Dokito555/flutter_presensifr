import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/data/model/check_location_model.dart';
import 'package:presensifr/data/model/location_model.dart';
import 'package:presensifr/provider/check_location_provider.dart';
import 'package:presensifr/widgets/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import '../../util/status_state.dart';

class PresencePage extends StatefulWidget {
  PresencePage({Key? key}) : super(key: key);

  @override
  State<PresencePage> createState() => _PresencePageState();
}

class _PresencePageState extends State<PresencePage> {

  File? imageFile;
  LocationModel _location = LocationModel();
  String address = 'User location';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presence'),
        backgroundColor: ColorPalette.primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    PickImage(),
                    const SizedBox(height: 60),
                    _getLocation(context),
                    const SizedBox(height: 220),
                    _buildButton(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pickImage(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          width: 130,
          child: imageFile == null
          ? InkWell(
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
            onTap: () {},
          )
          : ClipOval(
            child: Image.network(
              "",
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          )
        )
      ],
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.'
      );
    } 

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition =  await Geolocator.getLastKnownPosition();
    setState(() {
      _location.latitude = position.latitude;
      _location.longitude = position.longitude;
      _getCurrentAddress();
    });
  }

  Future<void> _getCurrentAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _location.latitude!,
        _location.longitude!
      );
      Placemark place = placemarks[0];
      setState(() {
        address = "${place.locality}, ${place.street}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _getLocation(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on,
          size: 40,
          color: Colors.blue,
        ),
        const SizedBox(height: 20.0),
        Text("${address}"),
        const SizedBox(height: 20),
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.greenColor,
            ),
            height: 40,
            width: 160,
            child: const Center(
              child: Text(
                'Current Location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
                ),
              ),
            ),
          ),
          onTap: () async {
            _determinePosition();
          },
        )
      ],
    );
  }

  Widget _buildButton(BuildContext context) {

    var checkLocationProvider = Provider.of<CheckLocationProvider>(context, listen: false);
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    Future<void> _checkLocation() async {

      _onLoading();

      await checkLocationProvider.checkCurrentLocation(
        _location.latitude.toString(), 
        _location.longitude.toString(), 
        loginProvider.loginResult.data!.result.nik
      );

      if (checkLocationProvider.status == Status.failed) {
        Fluttertoast.showToast(
          msg: 'Gagal Presensi',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1
        );
        Navigator.pop(context);
      } else if (loginProvider.status == Status.success) {
        print(checkLocationProvider.checkLocationResult.data!.result);
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPalette.primaryColor,
            ),
            height: 50,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Presence',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
            ),
          ),
          onTap: () async {
            _checkLocation();
          },
        )
      ],
    );
  }
}