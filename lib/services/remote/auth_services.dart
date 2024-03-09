import 'dart:convert';
import 'package:capstone2_clean_house/model/request/login_request_model.dart';
import 'package:capstone2_clean_house/model/request/register_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class AuthServices {
  Future<http.Response> register(RegisterRequestModel body);
  Future<http.Response> login(LoginRequestModel body);
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
}
