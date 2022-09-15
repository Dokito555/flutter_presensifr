import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/login_model.dart';
import 'package:http/http.dart' as http;
import '../data/model/response_model/login_response_model.dart';
import '../util/status_state.dart';

class LoginProvider extends ChangeNotifier {

  final ApiService apiService;

  LoginProvider({
    required this.apiService
  });
  
  late Status _status;
  late LoginResult _loginResult;
  String _message = '';

  Status get status => _status;
  String get message => _message;
  LoginResult get loginResult => _loginResult;

  Future<dynamic> postLogin(LoginModel loginData) async {
    try {
      _status = Status.loading;
      notifyListeners();
      final response = await ApiService.connectLogin(loginData);
      if (response.errCode != 0) {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to logged in';
      } else {
        _status = Status.success;
        notifyListeners();
        return _loginResult = response;
      }
    } catch (e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}