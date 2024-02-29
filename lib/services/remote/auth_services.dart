// import 'dart:convert';
// import 'package:capstone2_clean_house/components/constants/app_constant.dart';
// import 'package:capstone2_clean_house/services/remote/body/register_body.dart';
// import 'package:http/http.dart' as http;
// import 'package:pretty_http_logger/pretty_http_logger.dart';

// abstract class ImplAuthServices {
//   Future<http.Response> register(RegisterBody body);
// }

// class AuthServices implements ImplAuthServices {
//   static final httpLog = HttpWithMiddleware.build(middlewares: [
//     HttpLogger(logLevel: LogLevel.BODY),
//   ]);

//   @override
//   Future<http.Response> register(RegisterBody body) async {
//     const url = AppConstant.endPointAuthRegister;

//     http.Response response = await httpLog.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${null}',
//       },
//       body: jsonEncode(body.toJson()),
//     );
//     return response;
//   }
// }
