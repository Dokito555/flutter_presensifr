class SignupModel {

  SignupModel({
    required this.data,
    required this.email,
    required this.latitude,
    required this.lembaga,
    required this.name,
    required this.nik,
    required this.nip,
    required this.no_hp,
    required this.password,
    required this.unit_kerja,
  });

  final String data;
  final String email;
  String? latitude;
  final String lembaga;
  String? longitude;
  final String name;
  final String nik;
  final String nip;
  final String no_hp;
  final String password;
  final String unit_kerja;

  Map<String, String> toJson() {
    final Map<String, String> body = <String, String>{};
    body["data"] = data;
    body["email"] = email;
    body["latitude"] = latitude!;
    body["lembaga"] = lembaga;
    body["longitude"] = longitude!;
    body["name"] = name;
    body["nik"] = nik;
    body["nip"] = nip;
    body["no_hp"] = no_hp;
    body["password"] = password;
    body["unit_kerja"] = unit_kerja;
    return body;
  }

}