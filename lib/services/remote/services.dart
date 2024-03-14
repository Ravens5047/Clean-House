import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlServicesName {
  Future<http.Response> getListServices();
  Future<http.Response> searchServices(String name_service);
}

class ServicesName implements ImlServicesName {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> getListServices() async {
    const url = AppConstant.endPointGetListServices;
    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }

  @override
  Future<http.Response> searchServices(String name_service) async {
    String url = '${AppConstant.endPointSeachServices}?keyword=$name_service';
    return await httpLog.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }
}
