import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';

import '../util/status_state.dart';

class EmailVerificationProvider extends ChangeNotifier {

  late Status _status;
  late EmailVerificationResult _emailVerificationResult;
  String _message = '';

  Status get status => _status;
  EmailVerificationResult get emailVerificationResult => _emailVerificationResult;
  String get message => _message;

  Future<dynamic> postEmailVerification(String email, bool newEmail) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.emailVerification(email, newEmail);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to Verified';
      } else {
        _status = Status.success;
        notifyListeners();
        return _emailVerificationResult = response;
      }
    } catch(e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}