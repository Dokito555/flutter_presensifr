import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/util/status_state.dart';

import '../data/model/response_model/code_ver_response_model.dart';

class CodeVerificationProvider extends ChangeNotifier {

  late Status _status;
  late CodeVerificationResult _codeVerificationResult;
  String _message = '';

  Status get status => _status;
  CodeVerificationResult get codeVerificationResult => _codeVerificationResult;
  String get message => _message;

  Future<dynamic> codeVerify(int code, String email) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.codeVerification(code, email);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to verify';
      } else {
        _status = Status.verified;
        notifyListeners();
        return _codeVerificationResult = response;
      }
    } catch (e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}