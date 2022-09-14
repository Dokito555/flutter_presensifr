import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:presensifr/data/api/api_service.dart';
import 'package:presensifr/data/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/data/model/response_model/profile_response_model.dart';
import '../util/status_state.dart';

class LoginProvider extends ChangeNotifier {
  
  late Status _status;
  String _message = '';

  Status get status => _status;
  String get message => _message;

  Future<dynamic> postLogin(LoginModel body) async {
    try {
      _status = Status.loading;
      notifyListeners();
      http.Response response = (await ApiService.login(body))!;
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        _status = Status.connected;
        notifyListeners();
        return LoginResponse.fromJson(data);
      } else {
        _status = Status.failed;
        notifyListeners();
        return _message = 'Failed to login';
      }
    } catch(e) {
      _status = Status.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}