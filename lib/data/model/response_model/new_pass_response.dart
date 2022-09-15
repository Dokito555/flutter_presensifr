// To parse this JSON data, do
//
//     final newPasswordResponse = newPasswordResponseFromJson(jsonString);

import 'dart:convert';

class NewPasswordResponse {
    NewPasswordResponse({
        this.errCode,
        this.data,
    });

    int? errCode;
    Data? data;

    factory NewPasswordResponse.fromRawJson(String str) => NewPasswordResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewPasswordResponse.fromJson(Map<String, dynamic> json) => NewPasswordResponse(
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
