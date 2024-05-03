import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/request/order_details_request_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlOrderBooking {
  Future<http.Response> orderBookingDetails(OrderDetailsRequest body);
  Future<http.Response> getListOrderDetailsByUserID(int userId);
  Future<http.Response> getListOrderDetails();
  Future<http.Response> searchServicesBooking(String name_service);
  Future<http.Response> updateOrderStatus(int orderId);
}

class OrderBookingServices implements ImlOrderBooking {
  static final _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  @override
  Future<http.Response> orderBookingDetails(OrderDetailsRequest body) async {
    const url = AppConstant.endPointBookingOrderDetails;
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
  Future<http.Response> getListOrderDetailsByUserID(int userId) async {
    final url = AppConstant.endPointGetListOrderDetailsByUserID.replaceAll(
      ':id',
      userId.toString(),
    );
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    });
    return response;
  }

  @override
  Future<http.Response> getListOrderDetails() async {
    const url = AppConstant.endPointGetListOrderDetails;
    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  @override
  Future<http.Response> searchServicesBooking(String name_service) async {
    String url =
        '${AppConstant.endPointSeachServicesBooking}?keyword=$name_service';
    return await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
  }

  @override
  Future<http.Response> updateOrderStatus(int orderId) async {
    final url = AppConstant.endPointUpdateStatusIDOrder
        .replaceAll(':order_id', orderId.toString());
    final response = await _httpClient.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }
}
