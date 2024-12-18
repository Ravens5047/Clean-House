import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/request/order_details_request_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

abstract class ImlOrderBooking {
  Future<http.Response> orderBookingDetails(OrderDetailsRequest body);
  Future<http.Response> getListOrderDetailsByUserID(int userId);
  Future<http.Response> getListOrderDetails();
  Future<http.Response> searchServicesBooking(
      String service_name, int employeeCode);
  Future<http.Response> updateOrderStatus(int orderId);
  Future<http.Response> getListOrderDetailsByEmployeeCode(int employeeCode);
  Future<http.Response> getListOrderDetailsByWorkDate(
      String workDate, int employeeCode);
  // Future<http.Response> addCashPaymentToDatabase(
  //     int orderDetailId, double sumTotal);
  Future<Map<String, dynamic>> getStatusByEmployeeCode(int employeeCode);
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
  Future<http.Response> searchServicesBooking(
      String service_name, int employeeCode) async {
    String url =
        '${AppConstant.endPointSeachServicesBooking}?keyword=$service_name&employee_code=$employeeCode';
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

  @override
  Future<http.Response> getListOrderDetailsByEmployeeCode(
      int employeeCode) async {
    String url =
        AppConstant.endPointGetListOrderDetailsByEmployeeCode(employeeCode);
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
  Future<http.Response> getListOrderDetailsByWorkDate(
      String workDate, int employeeCode) async {
    final url =
        AppConstant.endPointSchudleWorkDateOrdersTasks(workDate, employeeCode);
    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  // @override
  Future<http.Response> addCashPaymentToDatabase(
      {required int orderDetailId, required double sumTotal}) async {
    const url = AppConstant.endPointBookingOrderDetails;
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'order_detail_id': orderDetailId,
        'sum_total': sumTotal,
      }),
    );
    return response;
  }

  @override
  Future<Map<String, dynamic>> getStatusByEmployeeCode(int employeeCode) async {
    final url = AppConstant.endPointGetStatusToEmployeeCode
        .replaceAll(':employeeCode', employeeCode.toString());

    final response = await _httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load status for employee code $employeeCode');
    }
  }
}
