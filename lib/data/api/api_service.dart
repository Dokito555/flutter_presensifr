import 'dart:convert';
import 'dart:developer';

import 'package:presensifr/data/model/login_model.dart';
import 'package:presensifr/data/model/response_model/code_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/data/model/response_model/new_pass_response.dart';
import 'package:presensifr/server.dart';
import 'package:presensifr/widgets/new_password.dart';

class ApiService {

  static Future<LoginResult> connectLogin(LoginModel loginData) async {

    const tenant = "grit";
    final url = Uri.parse(APIServer.urlLogin);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(loginData.toJson())
    );
    
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return LoginResult.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<EmailVerificationResult> emailVerification(String email, bool newEmail) async {
    
    const tenant = "grit";
    final url = Uri.parse(APIServer.urlEmailVerification);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "new_email": newEmail,
        "tenant": tenant
      })
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return EmailVerificationResult.fromJson(data);
    } else {
      throw Exception('Email Verification Failed');
    }
  }

  static Future<CodeVerificationResult> codeVerification(int code, String email) async {

    final url = Uri.parse(APIServer.urlCodeVerification);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        "code": code,
        "email": email
      })
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return CodeVerificationResult.fromJson(data);
    } else {
      throw Exception('Code Verification Failed');
    }
    
  }

  static Future<NewPasswordResult> updatePassword(String newpass, String email) async {

    final url = Uri.parse(APIServer.urlResetPassword);
    const tenant = "grit";

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "email" : email,
        "password" : newpass,
        "tenant" : tenant
      }) 
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return NewPasswordResult.fromJson(data);
    } else {
      throw Exception('Updating New Password Failed');
    }

  }

}