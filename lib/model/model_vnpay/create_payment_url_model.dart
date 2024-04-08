import 'package:intl/intl.dart';

class CreatePaymentModel {
  String? tmnCode;
  String? secretKey;
  String? vnpUrl;
  String? returnUrl;
  String? orderId;
  double? amount;
  String? bankCode;
  String? locale;
  String? currCode;
  String? ipAddr;
  String? createDate;

  CreatePaymentModel({
    this.tmnCode,
    this.secretKey,
    this.vnpUrl,
    this.returnUrl,
    this.amount,
    this.bankCode,
    this.locale,
    this.currCode,
    this.ipAddr,
    this.createDate,
  });

  factory CreatePaymentModel.fromJson(Map<String, dynamic> json) {
    return CreatePaymentModel(
      tmnCode: json['vnp_TmnCode'],
      secretKey: json['vnp_HashSecret'],
      vnpUrl: json['vnp_Url'],
      returnUrl: json['vnp_ReturnUrl'],
      amount: json['vnp_Amount'],
      bankCode: json['vnp_BankCode'],
      locale: json['vnp_Locale'],
      currCode: json['vnp_CurrCode'],
      ipAddr: json['vnp_IpAddr'],
      createDate: json['vnp_CreateDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vnp_TmnCode'] = tmnCode;
    data['vnp_HashSecret'] = secretKey;
    data['vnp_Url'] = vnpUrl;
    data['vnp_ReturnUrl'] = returnUrl;
    data['vnp_Amount'] = amount;
    data['vnp_BankCode'] = bankCode;
    data['vnp_Locale'] = locale;
    data['vnp_CurrCode'] = currCode;
    data['vnp_IpAddr'] = ipAddr;
    data['vnp_CreateDate'] = createDate;
    return data;
  }

  String? getFormattedOrderId() {
    return DateFormat('ddHHmmss').format(DateTime.now());
  }

  Map<String, dynamic> toParamsMap() {
    return {
      'vnp_Version': '2.1.0',
      'vnp_Command': 'pay',
      'vnp_TmnCode': tmnCode,
      'vnp_Locale': locale ?? 'vn',
      'vnp_CurrCode': currCode,
      'vnp_TxnRef': orderId,
      'vnp_OrderInfo': 'Thanh toan cho ma GD:$orderId',
      'vnp_OrderType': 'other',
      'vnp_Amount': (amount! * 100).toDouble(),
      'vnp_ReturnUrl': returnUrl,
      'vnp_IpAddr': ipAddr,
      'vnp_CreateDate': createDate,
      'vnp_BankCode': bankCode = '&language = vn',
    };
  }
}
