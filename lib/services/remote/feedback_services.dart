import 'dart:convert';

import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class FeedbackServices {
  Future<http.Response> searchFeedbacks();
  Future<http.Response> getFeedbackDetail(int id);
  Future<http.Response> addFeedback(FeedbackRequestModel body);
  Future<http.Response> updateFeedback(int id, FeedbackRequestModel body);
  Future<http.Response> deleteFeedback(int id);
  Future<http.Response> getFeedbackAll();
}

class FeedbackServiceAPI implements FeedbackServices {
  static final HttpWithMiddleware _httpClient =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> getFeedbackAll() async {
    const url = AppConstant.endPointGetFeedbackAll;
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
  Future<http.Response> addFeedback(FeedbackRequestModel body) async {
    const url = AppConstant.endPointAddFeedback;
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
  Future<http.Response> deleteFeedback(int id) async {
    final url = '${AppConstant.endPointDeleteFeedback}/$id';
    final response = await _httpClient.delete(Uri.parse(url));
    return response;
  }

  @override
  Future<http.Response> getFeedbackDetail(int id) async {
    final url = '${AppConstant.endPointgetFeedbackDetail}/$id';
    final response = await _httpClient.get(Uri.parse(url));
    return response;
  }

  @override
  Future<http.Response> searchFeedbacks() async {
    const url = AppConstant.endPointSearchFeedbacks;
    final response = await _httpClient.get(Uri.parse(url));
    return response;
  }

  @override
  Future<http.Response> updateFeedback(
      int id, FeedbackRequestModel body) async {
    final url = '${AppConstant.endPointUpdateFeedback}/$id';
    final response = await _httpClient.put(
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
