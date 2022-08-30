import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presensifr/server.dart';


class LoginResponse {
    LoginResponse({
        this.errCode,
        this.data,
    });

    int? errCode;
    Data? data;

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        errCode: json["err_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": data!.toJson(),
    };

    static Future<LoginResponse> connectLogin(String email, String password) async {

      var responseResult = await http.post(
        Uri.parse(APIServer.urlLogin),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: {
          "email" : email,
          "password" : password,
          "tenant" : "grit"
        }
      );

      final data = json.decode(responseResult.body);

      return LoginResponse(
        errCode: data["errCode"], 
        data: Data.fromJson(data["data"])
      );
    }
}

class Data {
    Data({
        required this.message,
        required this.result,
    });

    String message;
    Result result;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        required this.idFrUser,
        required this.nama,
        required this.nik,
        required this.nip,
        required this.role,
        required this.tenantName,
    });

    int idFrUser;
    String nama;
    String nik;
    String nip;
    int role;
    String tenantName;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        idFrUser: json["id_fr_user"],
        nama: json["nama"],
        nik: json["nik"],
        nip: json["nip"],
        role: json["role"],
        tenantName: json["tenant_name"],
    );

    Map<String, dynamic> toJson() => {
        "id_fr_user": idFrUser,
        "nama": nama,
        "nik": nik,
        "nip": nip,
        "role": role,
        "tenant_name": tenantName,
    };
}
