class RegisterRequestModel {
  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmpassword,
  });
  late final String username;
  late final String email;
  late final String phone;
  late final String password;
  late final String confirmpassword;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmpassword = json['confirmpassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['password'] = password;
    _data['confirmpassword'] = confirmpassword;
    return _data;
  }
}
