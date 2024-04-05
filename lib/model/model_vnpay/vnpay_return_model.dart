//Response VNPAY MODEL
class VnpayReturnModel {
  VnpayReturnModel({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  VnpayReturnModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }
}

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

  double? amount;
  String? bankCode;
  String? cardType;
  String? orderInfo;
  String? payDate;
  String? responseCode;
  String? tmnCode;
  String? transactionNo;
  String? transactionStatus;
  String? txnRef;
  String? secureHash;

  Data.fromJson(Map<String, dynamic> json) {
    amount = json["vnp_Amount"];
    bankCode = json["vnp_BankCode"];
    cardType = json["vnp_CardType"];
    orderInfo = json["vnp_OrderInfo"];
    payDate = json["vnp_PayDate"];
    responseCode = json["vnp_ResponseCode"];
    tmnCode = json["vnp_TmnCode"];
    transactionNo = json["vnp_TransactionNo"];
    transactionStatus = json["vnp_TransactionStatus"];
    txnRef = json["vnp_TxnRef"];
    secureHash = json["vnp_SecureHash"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['vnp_Amount'] = amount;
    _data['vnp_BankCode'] = bankCode;
    _data['vnp_CardType'] = cardType;
    _data['vnp_OrderInfo'] = orderInfo;
    _data['vnp_PayDate'] = payDate;
    _data['vnp_ResponseCode'] = responseCode;
    _data['vnp_TmnCode'] = tmnCode;
    _data['vnp_TransactionNo'] = transactionNo;
    _data['vnp_TransactionStatus'] = transactionStatus;
    _data['vnp_TxnRef'] = txnRef;
    _data['vnp_SecureHash'] = secureHash;
    return _data;
  }
}
