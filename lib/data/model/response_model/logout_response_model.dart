// To parse this JSON data, do
//
//     final profileResult = profileResultFromJson(jsonString);

import 'dart:convert';

class LogoutResult {
    LogoutResult({
        required this.errCode,
        required this.data,
    });

    int? errCode;
    Data? data;

    factory LogoutResult.fromRawJson(String str) => LogoutResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LogoutResult.fromJson(Map<String, dynamic> json) => LogoutResult(
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
        required this.result,
    });

    String message;
    String result;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "result": result,
    };
}
