import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class ImlVNPAY {
  Future<String> getPaymentUrl();
  Future<String> getVNPAYInfo();
}

class VNPAYServices implements ImlVNPAY {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<String> getPaymentUrl() async {
    final response = await http.get(
      AppConstant.endPointVNPAY as Uri,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load payment URL');
    }
  }

  @override
  Future<String> getVNPAYInfo() async {
    final response = await http.get(
      AppConstant.endPointVNPAY1 as Uri,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load VNPAY information');
    }
  }
}
