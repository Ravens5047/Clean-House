import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  String? message;
  Data? data;
  int? role;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data?.toJson();
    _data['role'] = role;
    return _data;
  }
}

class Data {
  Data({
    this.key,
    this.id,
  });
  String? key;
  int? id;
  int? role;

  Data.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['id'] = id;
    _data['role'] = role;
    return _data;
  }
}
