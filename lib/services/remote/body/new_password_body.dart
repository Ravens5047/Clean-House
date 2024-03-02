class NewPasswordBody {
  String? email;
  String? password;
  String? code; // OTP

  NewPasswordBody();

  // factory NewPasswordBody.fromJson(Map<String, dynamic> json) => NewPasswordBody()
  //   ..email = json['email'] as String?
  //   ..password = json['password'] as String?
  //   ..code = json['code'] as String?;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'code': code,
    };
  }
}
