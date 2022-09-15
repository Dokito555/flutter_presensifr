// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class ProfileResponse {
    ProfileResponse({
        required this.errCode,
        required this.data,
    });

    int errCode;
    Data data;

    factory ProfileResponse.fromRawJson(String str) => ProfileResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
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
        required this.nama,
        required this.email,
        required this.nik,
        required this.nip,
        required this.unitKerja,
        required this.noHp,
        required this.latitude,
        required this.longitude,
        required this.role,
        required this.lembaga,
        required this.image,
        required this.token,
        required this.status,
        required this.updatedAt,
    });

    String nama;
    String email;
    String nik;
    String nip;
    String unitKerja;
    String noHp;
    String latitude;
    String longitude;
    int role;
    String lembaga;
    String image;
    String token;
    String status;
    DateTime updatedAt;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        nama: json["nama"],
        email: json["email"],
        nik: json["nik"],
        nip: json["nip"],
        unitKerja: json["unit_kerja"],
        noHp: json["no_hp"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        role: json["role"],
        lembaga: json["lembaga"],
        image: json["image"],
        token: json["token"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "email": email,
        "nik": nik,
        "nip": nip,
        "unit_kerja": unitKerja,
        "no_hp": noHp,
        "latitude": latitude,
        "longitude": longitude,
        "role": role,
        "lembaga": lembaga,
        "image": image,
        "token": token,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
    };
}
