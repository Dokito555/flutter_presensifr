import 'dart:convert';
import 'dart:developer';

import 'package:presensifr/data/model/login_model.dart';
import 'package:presensifr/data/model/response_model/code_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/email_ver_response_model.dart';
import 'package:presensifr/data/model/response_model/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/data/model/response_model/logout_response_model.dart';
import 'package:presensifr/data/model/response_model/new_pass_response.dart';
import 'package:presensifr/data/model/response_model/profile_response_model.dart';
import 'package:presensifr/server.dart';

import '../model/response_model/history_response_model.dart';

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

  static Future<ProfileResult> getProfile(String nik, String nip) async {

    final url = Uri.parse(APIServer.urlProfile);
    const tenant = "grit";

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "nik": nik,
        "nip": nip,
        "tenant": tenant
      })
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return ProfileResult.fromJson(data);
    } else {
      throw Exception('Get Profil Failed');
    }
  }

  static Future<HistoryResult> getHistory(String nik, String nip) async {

    final url = Uri.parse(APIServer.urlHistory);
    final tenant = "grit";

    final response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String> {
        "nik": nik,
        "nip": nip,
        "tenant": tenant
      })
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return HistoryResult.fromJson(data);
    } else {
      throw Exception('Get History Failed');
    }
  }

  static Future<LogoutResult> logout(String nik, String nip) async {

    final url = Uri.parse(APIServer.urlLogout);
    const tenant = "grit";

    final response = await http.post(
      url,
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "nik": nik,
        "nip": nip,
        "tenant": tenant
      })
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return LogoutResult.fromJson(data);
    } else {
      throw Exception('Logout Failed');
    }
  }

}