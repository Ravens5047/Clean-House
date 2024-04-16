import 'dart:convert';

import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/order_details_model.dart';
import 'package:capstone2_clean_house/pages/history_order/detail_history_order.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({
    super.key,
  });

  @override
  State<HistoryOrder> createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  AppUsersModel appUser = AppUsersModel();
  final formKey = GlobalKey<FormState>();
  OrderBookingServices orderBookingServices = OrderBookingServices();
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  List<OrderDetailsModel> orderDetailsList = [];

  @override
  void initState() {
    _getListOrderDetails();
    super.initState();
  }

  void _getListOrderDetails() {
    orderBookingServices.getListOrderDetails().then((response) {
      if (response.statusCode == 200) {
        List<OrderDetailsModel> tempListOrderDetails = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          OrderDetailsModel orderDetails = OrderDetailsModel.fromJson(data);
          tempListOrderDetails.add(orderDetails);
        }
        print('Connection Successfully Call API');
        setState(() {
          orderDetailsList = tempListOrderDetails;
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((onError) {
      print('Error occurred: $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'History Order',
          style: GoogleFonts.mandali(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: orderDetailsList.length,
            itemBuilder: (context, index) {
              final orderDetails = orderDetailsList[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailHistoryOrder(
                      orderDetails: orderDetails,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ).copyWith(
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(
                        color: AppColor.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadow,
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '#${orderDetails.order_detail_id.toString()}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Text(
                            'Name Service: ${orderDetails.name_service ?? ''}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            'Work Date: ${orderDetails.work_date}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            'Time: ${orderDetails.start_time}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            'Total: ${orderDetails.sub_total_price != null ? NumberFormat('#,##0', 'en_US').format(orderDetails.sub_total_price) : 'N/A'} VND',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
