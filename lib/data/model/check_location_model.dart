class CheckLocationModel {
  String latitude;
  String longitude;
  String nik;
  String tenant = "grit";

  CheckLocationModel({
    required this.latitude,
    required this.longitude,
    required this.nik,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["nik"] = nik;
    data["tenant"] = tenant;
    return data;
  }
}