class RegisterRequestModel {
  String? username;
  String? password;
  String? email;
  String? phone_number;
  int? role;
  // int? employee_code;

  RegisterRequestModel({
    this.username,
    this.password,
    this.email,
    this.phone_number,
    this.role = 4,
    // this.employee_code = 0,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone_number = json['phone_number'];
    role = json['role'];
    // employee_code = json['employee_code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'phone_number': phone_number,
      'role': role,
      // 'employee_code': employee_code,
    };
  }
}
