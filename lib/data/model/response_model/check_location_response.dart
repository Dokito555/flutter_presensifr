// To parse this JSON data, do
//
//     final checkLocationResult = checkLocationResultFromJson(jsonString);

import 'dart:convert';

class CheckLocationResult {
    CheckLocationResult({
        required this.errCode,
        required this.data,
    });

    int? errCode;
    Data? data;

    factory CheckLocationResult.fromRawJson(String str) => CheckLocationResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CheckLocationResult.fromJson(Map<String, dynamic> json) => CheckLocationResult(
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
        required this.result,
    });

    Result result;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result.toJson(),
    };
}

class Result {
    Result({
        required this.status,
        required this.nik,
        required this.tenantId,
        required this.hourIn,
        required this.minuIn,
        required this.secoIn,
        required this.hourLate,
        required this.minuLate,
        required this.secoLate,
        required this.hourOut,
        required this.minuOut,
        required this.secoOut,
    });

    String status;
    String nik;
    int tenantId;
    int hourIn;
    int minuIn;
    int secoIn;
    int hourLate;
    int minuLate;
    int secoLate;
    int hourOut;
    int minuOut;
    int secoOut;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        nik: json["nik"],
        tenantId: json["tenant_id"],
        hourIn: json["hour_in"],
        minuIn: json["minu_in"],
        secoIn: json["seco_in"],
        hourLate: json["hour_late"],
        minuLate: json["minu_late"],
        secoLate: json["seco_late"],
        hourOut: json["hour_out"],
        minuOut: json["minu_out"],
        secoOut: json["seco_out"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "nik": nik,
        "tenant_id": tenantId,
        "hour_in": hourIn,
        "minu_in": minuIn,
        "seco_in": secoIn,
        "hour_late": hourLate,
        "minu_late": minuLate,
        "seco_late": secoLate,
        "hour_out": hourOut,
        "minu_out": minuOut,
        "seco_out": secoOut,
    };
}
