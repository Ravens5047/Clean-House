import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VnpayReturnModel {
  VnpayReturnModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory VnpayReturnModel.fromJson(Map<String, dynamic> json) =>
      _$VnpayReturnModelFromJson(json);

  Map<String, dynamic> toJson() => _$VnpayReturnModelToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.amount,
    this.bankCode,
    this.cardType,
    this.orderInfo,
    this.payDate,
    this.responseCode,
    this.tmnCode,
    this.transactionNo,
    this.transactionStatus,
    this.txnRef,
    this.secureHash,
  });

  @JsonKey(name: 'vnp_Amount')
  double? amount;
  @JsonKey(name: 'vnp_BankCode')
  String? bankCode;
  @JsonKey(name: 'vnp_CardType')
  String? cardType;
  @JsonKey(name: 'vnp_OrderInfo')
  String? orderInfo;
  @JsonKey(name: 'vnp_PayDate')
  String? payDate;
  @JsonKey(name: 'vnp_ResponseCode')
  String? responseCode;
  @JsonKey(name: 'vnp_TmnCode')
  String? tmnCode;
  @JsonKey(name: 'vnp_TransactionNo')
  String? transactionNo;
  @JsonKey(name: 'vnp_TransactionStatus')
  String? transactionStatus;
  @JsonKey(name: 'vnp_TxnRef')
  String? txnRef;
  @JsonKey(name: 'vnp_SecureHash')
  String? secureHash;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

VnpayReturnModel _$VnpayReturnModelFromJson(Map<String, dynamic> json) {
  return VnpayReturnModel(
    message: json['message'] as String?,
    data: json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
  );
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    amount: (json['vnp_Amount'] as num?)?.toDouble(),
    bankCode: json['vnp_BankCode'] as String?,
    cardType: json['vnp_CardType'] as String?,
    orderInfo: json['vnp_OrderInfo'] as String?,
    payDate: json['vnp_PayDate'] as String?,
    responseCode: json['vnp_ResponseCode'] as String?,
    tmnCode: json['vnp_TmnCode'] as String?,
    transactionNo: json['vnp_TransactionNo'] as String?,
    transactionStatus: json['vnp_TransactionStatus'] as String?,
    txnRef: json['vnp_TxnRef'] as String?,
    secureHash: json['vnp_SecureHash'] as String?,
  );
}

Map<String, dynamic> _$VnpayReturnModelToJson(VnpayReturnModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'vnp_Amount': instance.amount,
      'vnp_BankCode': instance.bankCode,
      'vnp_CardType': instance.cardType,
      'vnp_OrderInfo': instance.orderInfo,
      'vnp_PayDate': instance.payDate,
      'vnp_ResponseCode': instance.responseCode,
      'vnp_TmnCode': instance.tmnCode,
      'vnp_TransactionNo': instance.transactionNo,
      'vnp_TransactionStatus': instance.transactionStatus,
      'vnp_TxnRef': instance.txnRef,
      'vnp_SecureHash': instance.secureHash,
    };
