// To parse this JSON data, do
//
//     final newPasswordResponse = newPasswordResponseFromJson(jsonString);

import 'dart:convert';

class NewPasswordResult {
    NewPasswordResult({
        this.errCode,
        this.data,
    });

    int? errCode;
    Data? data;

    factory NewPasswordResult.fromRawJson(String str) => NewPasswordResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewPasswordResult.fromJson(Map<String, dynamic> json) => NewPasswordResult(
        errCode: json["err_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        required this.message,
    });

    String message;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
