import 'package:intl/intl.dart';

class OrderDetailsModel {
  final int? status_id;
  final int? total_price;
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
  final String? name_service;
  final int? user_id;

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
    this.name_service,
    this.user_id,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('dd-MM-yyyy');
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
      total_price: json['total_price'] as int?,
      name_service: json['name_service'] as String?,
      user_id: json['user_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_detail_id": order_detail_id,
      "oder_id": order_id,
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
      "name_service": name_service,
      "user_id": user_id,
    };
  }
}
