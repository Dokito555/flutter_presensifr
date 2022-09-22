class HistoryResult {
  int? errCode;
  Data? data;

  HistoryResult({this.errCode, this.data});

  HistoryResult.fromJson(Map<String, dynamic> json) {
    errCode = json['err_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err_code'] = this.errCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;
  Result? result;

  Data({this.message, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<CheckIn>? checkIn;
  List<CheckOut>? checkOut;

  Result({this.checkIn, this.checkOut});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['check_in'] != null) {
      checkIn = <CheckIn>[];
      json['check_in'].forEach((v) {
        checkIn!.add(new CheckIn.fromJson(v));
      });
    }
    if (json['check_out'] != null) {
      checkOut = <CheckOut>[];
      json['check_out'].forEach((v) {
        checkOut!.add(new CheckOut.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.checkIn != null) {
      data['check_in'] = this.checkIn!.map((v) => v.toJson()).toList();
    }
    if (this.checkOut != null) {
      data['check_out'] = this.checkOut!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckIn {
  String? createdAt;
  String? late;
  String? location;
  String? place;
  String? folder;
  String? filename;
  String? tujuan;
  String? link;

  CheckIn(
      {this.createdAt,
      this.late,
      this.location,
      this.place,
      this.folder,
      this.filename,
      this.tujuan,
      this.link});

  CheckIn.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    late = json['late'];
    location = json['location'];
    place = json['place'];
    folder = json['folder'];
    filename = json['filename'];
    tujuan = json['tujuan'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['late'] = this.late;
    data['location'] = this.location;
    data['place'] = this.place;
    data['folder'] = this.folder;
    data['filename'] = this.filename;
    data['tujuan'] = this.tujuan;
    data['link'] = this.link;
    return data;
  }
}

class CheckOut {
  String? createdAt;
  String? early;
  String? location;
  String? place;
  String? folder;
  String? filename;
  String? tujuan;
  String? link;

  CheckOut(
      {this.createdAt,
      this.early,
      this.location,
      this.place,
      this.folder,
      this.filename,
      this.tujuan,
      this.link});

  CheckOut.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    early = json['early'];
    location = json['location'];
    place = json['place'];
    folder = json['folder'];
    filename = json['filename'];
    tujuan = json['tujuan'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['early'] = this.early;
    data['location'] = this.location;
    data['place'] = this.place;
    data['folder'] = this.folder;
    data['filename'] = this.filename;
    data['tujuan'] = this.tujuan;
    data['link'] = this.link;
    return data;
  }
}