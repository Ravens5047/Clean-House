import 'dart:convert';

import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/history_order/detail_history_order.dart';
import 'package:capstone2_clean_house/pages/homscreen_employee/home_screen_employee.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:capstone2_clean_house/services/remote/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:intl/intl.dart';

class HistoryOrderSuccessfully extends StatefulWidget {
  const HistoryOrderSuccessfully({super.key});

  @override
  State<HistoryOrderSuccessfully> createState() =>
      _HistoryOrderSuccessfullyState();
}

class _HistoryOrderSuccessfullyState extends State<HistoryOrderSuccessfully> {
  final searchController = TextEditingController();
  AppUsersModel appUser = AppUsersModel();
  final formKey = GlobalKey<FormState>();
  ServicesName servicesName = ServicesName();
  List<ServicesModel> servicesList = [];
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

  void _reloadUI() {
    _getListOrderDetailsByUser_ID();
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
            if (orderDetails.status_id == 2) {
              tempListOrderDetails.add(orderDetails);
            }
          }
          print(userId);
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
    } else {
      print('User_id not found in SharedPreferences');
    }
  }

  DateTime? addOneDay(DateTime? date) {
    if (date != null) {
      return date.add(const Duration(days: 1));
    }
    return null;
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

  double calculateTotalPrice() {
    double total = 0.0;
    for (var orderDetails in orderDetailsList) {
      if (orderDetails.sub_total_price != null) {
        total += orderDetails.sub_total_price!;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = calculateTotalPrice();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Done History',
          style: GoogleFonts.dmSerifText(
            fontSize: 22.0,
            fontWeight: FontWeight.w200,
            color: AppColor.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
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
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Total of The Bill Order: ${NumberFormat('#,##0', 'en_US').format(totalAmount)} VND',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.green,
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 5.0,
                        ),
                        child: Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(
                              color: AppColor.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
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
                                        'Status Bill',
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
                                            'Processing',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black,
                                            ),
                                          )
                                        : orderDetails.status_id == 2
                                            ? const Text(
                                                'Success Payment',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.green,
                                                ),
                                              )
                                            : const SizedBox(),
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
            ],
          ),
        ),
      ),
    );
  }
}
