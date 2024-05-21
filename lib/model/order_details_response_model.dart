import 'package:intl/intl.dart';

class OrderDetailsModel {
  int? status_id;
  final double? total_price;
  final int? order_detail_id;
  final int? order_id;
  final double? sub_total_price;
  final int? service_id;
  final String? note;
  final double? unit_price;
  final String? address_order;
  final String? full_name;
  final String? phone_number;
  final String? houseType;
  final String? area;
  final String? work_date;
  final String? start_time;
  final String? service_name;
  final int? user_id;
  final String? estimated_time;
  final String? txn_ref;
  final String? amount;
  final String? order_infor;
  final String? status;
  final String? vnp_ResponseCode;
  final String? payment;
  final int? statusPaymentId;
  final String? status_payment;
  final String? notification;
  final String? status_name;
  final int? employee_code;

  OrderDetailsModel({
    this.order_detail_id,
    this.order_id,
    this.sub_total_price,
    this.service_id,
    this.note,
    this.unit_price,
    this.address_order,
    this.full_name,
    this.phone_number,
    this.houseType,
    this.area,
    this.work_date,
    this.start_time,
    this.status_id = 1,
    this.total_price,
    this.service_name,
    this.user_id,
    this.estimated_time,
    this.txn_ref,
    this.amount,
    this.order_infor,
    this.status,
    this.vnp_ResponseCode,
    this.payment,
    this.statusPaymentId,
    this.status_payment,
    this.notification,
    this.status_name,
    this.employee_code,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final String formattedWorkDate = json['work_date'] != null
        ? dateFormat.format(DateTime.parse(json['work_date'].toString()))
        : '';

    return OrderDetailsModel(
      order_detail_id: json['order_detail_id'] as int?,
      order_id: json['order_id'] as int?,
      sub_total_price: json['sub_total_price'] != null
          ? double.tryParse(json['sub_total_price'].toString())
          : null,
      service_id: json['service_id'] as int?,
      note: json['note'] as String?,
      unit_price: json['unit_price'] != null
          ? double.tryParse(json['unit_price'].toString())
          : null,
      address_order: json['address_order'] as String?,
      work_date: formattedWorkDate,
      start_time: json['start_time']?.toString().substring(0, 5),
      full_name: json['full_name'] as String?,
      phone_number: json['phone_number'] as String?,
      houseType: json['housetype'] as String?,
      area: json['area'] as String?,
      status_id: json['status_id'] as int?,
      total_price: json['total_price'] as double?,
      service_name: json['service_name'] as String?,
      user_id: json['user_id'] as int?,
      estimated_time: json['estimated_time'] as String?,
      txn_ref: json['txn_ref'] as String?,
      amount: json['amount'] as String?,
      order_infor: json['order_infor'] as String?,
      status: json['status'] as String?,
      vnp_ResponseCode: json['vnp_ResponseCode'] as String?,
      payment: json['payment'] as String?,
      statusPaymentId: json['status_payment_id'] as int?,
      status_payment: json['status_payment'] as String?,
      notification: json['notification'] as String?,
      status_name: json['status_name'] as String?,
      employee_code: json['employee_code'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_detail_id": order_detail_id,
      "order_id": order_id,
      "sub_total_price": sub_total_price,
      "service_id": service_id,
      "note": note,
      "unit_price": unit_price,
      "address_order": address_order,
      "full_name": full_name,
      "phone_number": phone_number,
      "housetype": houseType,
      "area": area,
      "work_date": work_date,
      "start_time": start_time,
      "status_id": status_id,
      "total_price": total_price,
      "service_name": service_name,
      "user_id": user_id,
      "estimated_time": estimated_time,
      "txn_ref": txn_ref,
      "amount": amount,
      "order_infor": order_infor,
      "status": status,
      "vnp_ResponseCode": vnp_ResponseCode,
      "payment": payment,
      "status_payment_id": statusPaymentId,
      "status_payment": status_payment,
      "notification": notification,
      "status_name": status_name,
      "employee_code": employee_code,
    };
  }
}
