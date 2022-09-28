import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/check_location_model.dart';
import 'package:presensifr/data/model/response_model/check_location_response.dart';

import '../util/status_state.dart';

class CheckLocationProvider extends ChangeNotifier {

  late Status _status;
  CheckLocationResult? _checkLocationResult;
  String _message = '';

  Status get status => _status;
  CheckLocationResult get checkLocationResult => _checkLocationResult!;
  String get message => _message;

  Future<dynamic> checkCurrentLocation(String lat, String long, String nik) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.checkLocation(lat, long, nik);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to check location';
      } else {
        _status = Status.success;
        notifyListeners();
        return _checkLocationResult = response;
      }
    } catch (e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}