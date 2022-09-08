import 'dart:convert';
import 'dart:developer';

import 'package:presensifr/data/model/email_ver_response_model.dart';
import 'package:presensifr/data/model/login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:presensifr/server.dart';

class ApiService {

  static Future<LoginResponse> connectLogin(String email, String password) async {

    const tenant = "grit";
    final url = Uri.parse(APIServer.urlLogin);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "email" : email,
        "password" : password,
        "tenant" : tenant
      })
    );

    // http.Response? response;

    // try {
    //   response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       'Content-Type' : 'application/json'
    //     },
    //     body: jsonEncode(<String, String> {
    //       "email" : email,
    //       "password" : password,
    //       "tenant" : tenant
    //     })
    //   );
    // } catch(e) {
    //   log(e.toString());
    // }

    // print('Response req : ${response.request}');
    // print('Response status : ${response.statusCode}');
    // print('Response body : ${response.body}');

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }

  }

  static Future<EmailVerResponse> verEmail(String email) async {
    
    const tenant = "grit";
    const newEmail = false;
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

    print('Response req : ${response.request}');
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return EmailVerResponse.fromJson(data);
    } else {
      throw Exception('Email Verification Failed');
    }
  }

}