import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlAccountService {
  Future<http.Response> getDetailUser(int user_id);
}

class AccountService implements ImlAccountService {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<http.Response> getDetailUser(int user_id) async {
    const url = AppConstant.endPointGetDetailUser;
    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPrefs.token}',
      },
    );
  }
}
