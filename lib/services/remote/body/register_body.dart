class RegisterBody {
  String? name;
  String? email;
  String? phone;
  String? password;

  RegisterBody();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
