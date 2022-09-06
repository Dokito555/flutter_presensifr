import 'dart:convert';

class EmailVerResponse {
    EmailVerResponse({
        required this.errCode,
        required this.data,
    });

    int errCode;
    Data data;

    factory EmailVerResponse.fromRawJson(String str) => EmailVerResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EmailVerResponse.fromJson(Map<String, dynamic> json) => EmailVerResponse(
        errCode: json["err_code"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": data.toJson(),
    };
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
        required this.email,
        required this.code1,
        required this.code2,
        required this.code3,
    });

    String email;
    int code1;
    int code2;
    int code3;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        email: json["email"],
        code1: json["code_1"],
        code2: json["code_2"],
        code3: json["code_3"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "code_1": code1,
        "code_2": code2,
        "code_3": code3,
    };
}
