class RegisterRequestModel {
  String? username;
  String? password;
  String? email;
  String? phone;
  int? role;

  RegisterRequestModel({
    this.username,
    this.password,
    this.email,
    this.phone,
    this.role = 3,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}
