import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    this.message,
    this.data,
  });
  String? message;
  Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.username,
    this.email,
    this.token,
    // this.employee_code,
  });
  String? username;
  String? email;
  String? token;
  // int? employee_code;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    token = json['token'];
    // employee_code = json['employee_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['token'] = token;
    // _data['employee_code'] = employee_code;
    return _data;
  }
}
