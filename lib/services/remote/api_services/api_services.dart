import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/auth/login_auth_model/login_request_model.dart';
import 'package:capstone2_clean_house/model/auth/register_auth_model/register_request_model.dart';
import 'package:capstone2_clean_house/model/auth/register_auth_model/register_response_model.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(AppConstant.apiURL, AppConstant.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      //SHARE
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(AppConstant.apiURL, AppConstant.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }
}
