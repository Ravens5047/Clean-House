import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/model_vnpay/create_payment_url_model.dart';
import 'package:capstone2_clean_house/model/model_vnpay/vnpay_return_model.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class ImlVnpayService {
  Future<http.Response> createPaymentUrl(CreatePaymentModel body);
  Future<http.Response> vnpayReturnUrl(VnpayReturnModel body);
}

class VnpayService extends ImlVnpayService {
  static final HttpWithMiddleware _httpClient = HttpWithMiddleware.build(
    middlewares: [
      HttpLogger(
        logLevel: LogLevel.BODY,
      ),
    ],
  );

  @override
  Future<http.Response> createPaymentUrl(CreatePaymentModel body) async {
    const url = AppConstant.endPointCreatePaymentURL;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body.toParamsMap()),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['vnp_Url'];
    } else {
      throw Exception('Failed to create payment URL');
    }
  }

  @override
  Future<http.Response> vnpayReturnUrl(VnpayReturnModel body) async {
    const url = AppConstant.endPointReturn;
    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
