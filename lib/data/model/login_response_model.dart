// To parse this JSON data, do
//
//     final empty = emptyFromJson(jsonString);

import 'dart:convert';

Empty emptyFromJson(String str) => Empty.fromJson(json.decode(str));

String emptyToJson(Empty data) => json.encode(data.toJson());

class Empty {
    Empty({
        required this.errCode,
        required this.data,
    });

    int errCode;
    Data data;

    factory Empty.fromJson(Map<String, dynamic> json) => Empty(
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
