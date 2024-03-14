import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlProductServices {
  Future<http.Response> getListProduct();
}

class ProductService implements ImlProductServices {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> getListProduct() async {
    const url = AppConstant.endPointGetListServices;
    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }
}
