import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlAccountService {
  Future<http.Response> getDetailUser(int user_id);
  Future<http.Response> UpdateDetailUser(int user_id, dynamic data);
}

class AccountService implements ImlAccountService {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<http.Response> getDetailUser(int user_id) async {
    String url = AppConstant.endPointGetDetailUser.replaceFirstMapped(
      RegExp(':id'),
      (match) => user_id.toString(),
    );

    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
    );
  }

  @override
  Future<http.Response> UpdateDetailUser(int user_id, dynamic data) async {
    String url = AppConstant.endPointUpdateDetailUser.replaceFirstMapped(
      RegExp(':id'),
      (match) => user_id.toString(),
    );

    return await httpLog.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
      body: jsonEncode(data),
    );
  }
}
