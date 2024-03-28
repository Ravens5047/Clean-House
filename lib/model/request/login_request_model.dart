class LoginRequestModel {
  String? username;
  String? password;
  int? role;

  LoginRequestModel({
    this.username,
    this.password,
    this.role = 4,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    role = json['role'];
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
