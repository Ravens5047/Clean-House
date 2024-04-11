import 'dart:convert';
import 'package:capstone2_clean_house/model/request/change_password_otp_request_model.dart';
import 'package:capstone2_clean_house/model/request/change_password_request_model.dart';
import 'package:capstone2_clean_house/model/request/forgot_password_request_model.dart';
import 'package:capstone2_clean_house/model/request/login_request_model.dart';
import 'package:capstone2_clean_house/model/request/register_request_model.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class AuthServices {
  Future<http.Response> register(RegisterRequestModel body);
  Future<http.Response> login(LoginRequestModel body);
  Future<http.Response> login1(LoginRequestModel body);
  Future<http.Response> changePassword(int user_id, ChangePasswordRequest body);
  Future<http.Response> forgotPassword(ForgotPasswordRequest body);
  Future<http.Response> changePasswordOTP(ChangePasswordOtpRequest body);
  Future<http.Response> resendOTP(String email);
}

class APIService implements AuthServices {
  static final HttpWithMiddleware _httpClient = HttpWithMiddleware.build(
      middlewares: [HttpLogger(logLevel: LogLevel.BODY)]);

  @override
  Future<http.Response> login(LoginRequestModel body) async {
    const url = AppConstant.endPointLogin;

    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> login1(LoginRequestModel body) async {
    const url = AppConstant.endPointLogin1;

    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> register(RegisterRequestModel body) async {
    const url = AppConstant.endPointRegister;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> changePassword(
      int user_id, ChangePasswordRequest body) async {
    String? endPoint = AppConstant.endPointChangePassword;
    String url = endPoint.replaceFirstMapped(
      RegExp(':id'),
      (match) => user_id.toString(),
    );

    final response = await _httpClient.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> forgotPassword(ForgotPasswordRequest body) async {
    const url = AppConstant.endPointForgotPassword;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> changePasswordOTP(ChangePasswordOtpRequest body) async {
    const url = AppConstant.endPointChangePasswordOTP;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toJson()),
    );
    return response;
  }

  @override
  Future<http.Response> resendOTP(String email) async {
    const url = AppConstant.endPointResendOTP;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );
    return response;
  }
}
