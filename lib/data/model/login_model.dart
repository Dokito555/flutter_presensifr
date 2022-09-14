class LoginModel {

  LoginModel({
    required this.email,
    required this.password
  });

  final String email;
  final String password;
  final String tenant = "grit";

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data["email"] = email;
    data["password"] = password;
    data["tenant"] = tenant;
    return data;
  }
}