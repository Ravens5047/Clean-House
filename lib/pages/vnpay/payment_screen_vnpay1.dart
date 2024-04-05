import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VnpayScreenPayment1 extends StatefulWidget {
  const VnpayScreenPayment1({super.key});

  @override
  State<VnpayScreenPayment1> createState() => _VnpayScreenPayment1State();
}

class _VnpayScreenPayment1State extends State<VnpayScreenPayment1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Payment VNPAY'),
        centerTitle: true,
      ),
      body: const InAppWebView(),
    );
  }
}
