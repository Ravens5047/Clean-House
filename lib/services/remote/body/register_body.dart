class RegisterBody {
  String? name;
  String? email;
  // String? phone;
  String? password;
  String? code; //OTP

  RegisterBody();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      // 'phone': phone,
      'password': password,
      'code': code,
    };
  }
}
