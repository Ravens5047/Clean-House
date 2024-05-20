import 'dart:convert';
import 'dart:typed_data';
import 'package:bottom_picker/resources/time.dart';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/request/order_details_request_model.dart';
import 'package:capstone2_clean_house/pages/notifications/notification_service.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:capstone2_clean_house/pages/payment/successful_payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VnpayScreenPayment1 extends StatefulWidget {
  const VnpayScreenPayment1({
    super.key,
    this.money,
    this.selectedTime,
    this.selectedDate,
    this.selectedHouse,
    this.selectedArea,
    this.address,
    this.fullname,
    this.note,
    this.total_price,
    this.phone_number,
    this.service_name,
    this.service_id,
    this.static_id,
    this.estimated_time,
    this.vnp_ResponseCode,
    this.payment,
    this.status_payment,
    this.notifications,
  });

  final String? money;
  final Time? selectedTime;
  final DateTime? selectedDate;
  final int? selectedHouse;
  final int? selectedArea;
  final String? address;
  final String? fullname;
  final String? phone_number;
  final String? service_name;
  final String? note;
  final double? total_price;
  final int? service_id;
  final int? static_id;
  final String? estimated_time;
  final String? vnp_ResponseCode;
  final String? payment;
  final String? status_payment;
  final List<Map<String, String>>? notifications;

  @override
  State<VnpayScreenPayment1> createState() => _VnpayScreenPayment1State();
}

class _VnpayScreenPayment1State extends State<VnpayScreenPayment1> {
  TextEditingController moneyController = TextEditingController();
  int? selectedHouse;
  int? selectedArea;
  AccountService accountService = AccountService();
  late int userId;
  final formKey = GlobalKey<FormState>();
  late String responseCode;
  final List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    selectedHouse = widget.selectedHouse;
    selectedArea = widget.selectedArea;
    responseCode = widget.vnp_ResponseCode ?? '';
  }

  String getHouseType(int index) {
    switch (index) {
      case 0:
        return 'House / Town House';
      case 1:
        return 'Apartment';
      case 2:
        return 'Villas';
      default:
        return '';
    }
  }

  String getArea(int index) {
    switch (index) {
      case 0:
        return 'Max 15m²';
      case 1:
        return 'Max 25m²';
      case 2:
        return 'Max 40m²';
      case 3:
        return 'Max 60m²';
      case 4:
        return 'Max 80m²';
      case 5:
        return 'Max 100m²';
      default:
        return '';
    }
  }

  Future<void> _bookOrderDetails() async {
    try {
      int? userId = SharedPrefs.user_id;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not logged in.'),
        ));
        return;
      }
      OrderDetailsRequest orderDetails = OrderDetailsRequest(
        service_name: widget.service_name,
        status_id: 1,
        sub_total_price: widget.total_price?.toDouble(),
        service_id: widget.service_id,
        note: widget.note,
        unit_price: widget.total_price?.toDouble(),
        address_order: widget.address,
        full_name: widget.fullname,
        phone_number: widget.phone_number,
        houseType: getHouseType(widget.selectedHouse!),
        area: getArea(widget.selectedArea!),
        work_date: DateFormat('yyyy-MM-dd').format(widget.selectedDate!),
        start_time:
            '${widget.selectedTime!.hours.toString().padLeft(2, '0')}:${widget.selectedTime!.minutes.toString().padLeft(2, '0')}',
        user_id: userId,
        estimated_time: widget.estimated_time,
        vnp_ResponseCode: responseCode,
        payment: widget.payment,
        status_payment: widget.status_payment,
        notification: notifications.toString(),
      );
      final response =
          await OrderBookingServices().orderBookingDetails(orderDetails);
      if (response.statusCode == 200) {
        await NotificationServices.showNotification(
          title: 'Booking successful!',
          body: 'We will confirm your booking shortly.',
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.blue,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

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
      body: Form(
        key: formKey,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(AppConstant.endPointCreatePaymentURL),
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
                    this.responseCode = responseCode;
                    await _bookOrderDetails();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Booking successful!'),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessfulPayment(
                          payment: widget.payment,
                          status_payment: widget.status_payment,
                          result: responseCode,
                          notifications: notifications,
                        ),
                      ),
                    );
                    print(responseCode);
                    debugPrint('Payment successfull!');
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
      ),
    );
  }
}
