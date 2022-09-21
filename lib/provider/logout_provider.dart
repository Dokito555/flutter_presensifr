import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';

import '../data/model/response_model/logout_response_model.dart';
import '../util/status_state.dart';

class LogoutProvider extends ChangeNotifier {

  late Status _status;
  late LogoutResult _logoutResult;
  String _message = '';

  Status get status => _status;
  LogoutResult get logoutResult => _logoutResult;
  String get message => _message;

  Future<dynamic> logout(String nik, String nip) async {
    try{
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.logout(nik, nip);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to logout';
      } else {
        _status = Status.success;
        notifyListeners();
        return _logoutResult = response;
      }
    } catch(e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}