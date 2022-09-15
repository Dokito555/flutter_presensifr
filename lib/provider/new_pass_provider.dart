import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/new_pass_response.dart';
import 'package:presensifr/util/status_state.dart';

class NewPasswordProvider extends ChangeNotifier {

  late Status _status;
  late NewPasswordResult _newPasswordResult;
  String _message = '';

  Status get status => _status;
  NewPasswordResult get newPasswordResult => _newPasswordResult;
  String get message => _message;

  Future<dynamic> postNewPassword(String email, String newpass) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.updatePassword(newpass, email);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to update password';
      } else {
        _status = Status.success;
        notifyListeners();
        return _newPasswordResult = response;
      }
    } catch(e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}