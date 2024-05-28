import 'dart:convert';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/pages/history_order/detail_history_order.dart';
import 'package:capstone2_clean_house/pages/homscreen_employee/home_screen_employee.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';
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
  FilterCriteria? currentFilter;
  bool isAscending = true;

  @override
  void initState() {
    _getListOrderDetailsByUser_ID();
    super.initState();
  }

  void _getListOrderDetailsByUser_ID() {
    int? userId = SharedPrefs.user_id;
    if (userId != null) {
      orderBookingServices.getListOrderDetailsByUserID(userId).then((response) {
        if (response.statusCode == 200) {
          List<OrderDetailsModel> tempListOrderDetails = [];
          List<dynamic> responseData = jsonDecode(response.body);
          for (var data in responseData) {
            OrderDetailsModel orderDetails = OrderDetailsModel.fromJson(data);
            tempListOrderDetails.add(orderDetails);
            print(orderDetails.work_date);
          }
          print(userId);
          print('Connection Successfully Call API');
          print('Response Body: ${_prettyJson(response.body)}');
          setState(() {
            orderDetailsList = tempListOrderDetails;
          });
        } else {
          print('Failed to load data from API');
        }
      }).catchError((onError) {
        print('Error occurred: $onError');
      });
    } else {
      print('User_id not found in SharedPreferences');
    }
  }

  String _prettyJson(String input) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    return encoder.convert(jsonDecode(input));
  }

  void _handleSort() {
    setState(() {
      if (currentFilter != FilterCriteria.ByWorkDate) {
        isAscending = true;
        orderDetailsList.sort((a, b) {
          final DateTime? dateA = parseDate(a.work_date);
          final DateTime? dateB = parseDate(b.work_date);
          return dateA!.compareTo(dateB!);
        });
        currentFilter = FilterCriteria.ByWorkDate;
      } else {
        isAscending = !isAscending;
        orderDetailsList.sort((a, b) {
          final DateTime? dateA = parseDate(a.work_date);
          final DateTime? dateB = parseDate(b.work_date);
          return dateB!.compareTo(dateA!);
        });
        currentFilter = null;
      }
    });
  }

  DateTime? parseDate(String? dateStr) {
    try {
      if (dateStr != null) {
        return DateFormat('yyyy-MM-dd').parse(dateStr);
      }
    } catch (e) {
      print('Invalid date format: $dateStr');
    }
    return null;
  }

  void _reloadUI() {
    _getListOrderDetailsByUser_ID();
  }

  DateTime? addOneDay(DateTime? date) {
    if (date != null) {
      return date.add(const Duration(days: 1));
    }
    return null;
  }

  @override
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
        actions: [
          IconButton(
            icon: Ikonate(
              color: AppColor.black,
              isAscending ? Ikonate.sort_down : Ikonate.sort_up,
            ),
            onPressed: () {
              _handleSort();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _reloadUI();
            },
          ),
        ],
        title: Text(
          'History Booking',
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
          child: orderDetailsList.isEmpty
              ? const Center(
                  child: Text(
                    'No orders available',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: orderDetailsList.length,
                  itemBuilder: (context, index) {
                    final orderDetails = orderDetailsList[index];
                    final DateTime? workDateWithOneDay =
                        addOneDay(parseDate(orderDetails.work_date));
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailHistoryOrder(
                            orderDetails: orderDetails,
                            order_details_id: orderDetails.order_detail_id ?? 0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 5.0,
                        ),
                        child: Container(
                          height: 220.0,
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
                                  'Service Name: ${orderDetails.service_name ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                  ),
                                ),
                                Text(
                                  'Work Date: ${workDateWithOneDay != null ? DateFormat('yyyy-MM-dd').format(workDateWithOneDay) : 'N/A'}',
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
                                Row(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Status:',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.black,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    orderDetails.status_id == 1
                                        ? const Text(
                                            'Pending confirmation',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.orange,
                                            ),
                                          )
                                        : orderDetails.status_id == 2
                                            ? const Text(
                                                'In Progress',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.green,
                                                ),
                                              )
                                            : orderDetails.status_id == 3
                                                ? const Text(
                                                    'Completed',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColor.blue,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Payment Method:',
                                      style: TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      orderDetails.payment ?? '',
                                      style: const TextStyle(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
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
