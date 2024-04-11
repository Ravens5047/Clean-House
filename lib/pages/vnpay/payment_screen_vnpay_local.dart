import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:capstone2_clean_house/pages/payment/successful_payment.dart';
import 'package:flutter/material.dart';

class VnpayScreenPayment1 extends StatefulWidget {
  const VnpayScreenPayment1({
    super.key,
    required this.money,
  });

  final String money;

  @override
  State<VnpayScreenPayment1> createState() => _VnpayScreenPayment1State();
}

class _VnpayScreenPayment1State extends State<VnpayScreenPayment1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VNPAY Client"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("http://192.168.1.180:8888/order/create_payment_url"),
          method: 'POST',
          body: Uint8List.fromList(
            utf8.encode(
              "amount=${widget.money}&bankCode=&language=vn",
            ),
          ),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
        onWebViewCreated: (controller) {
          debugPrint("Opened web successfully");
        },
        onLoadStop: (controller, url) async {
          if (url.toString().contains("/order/vnpay_return")) {
            var response = await controller.evaluateJavascript(
              source: 'document.body.innerText',
            );
            print(response);
            if (response.isNotEmpty) {
              try {
                Uri uri = Uri.parse(url.toString());
                String responseCode =
                    uri.queryParameters['vnp_ResponseCode'] ?? '';
                if (responseCode == '00') {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessfulPayment(
                        result: responseCode,
                      ),
                    ),
                  );
                  print(responseCode);
                  debugPrint('Payment successful!');
                } else {
                  print('Payment failed: $responseCode');
                }
              } catch (e) {
                print('Error handling response: $e');
              }
            } else {
              print('Empty response received');
            }
          }
        },
      ),
    );
  }
}
