import 'dart:convert';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/pages/history_order/detail_history_order.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SchudleMainPageCustomer extends StatefulWidget {
  const SchudleMainPageCustomer({super.key});

  @override
  State<SchudleMainPageCustomer> createState() =>
      _SchudleMainPageCustomerState();
}

class _SchudleMainPageCustomerState extends State<SchudleMainPageCustomer> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<OrderDetailsModel> orderDetailsList = [];
  final orderBookingServices = OrderBookingServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Table Calendar',
            style: GoogleFonts.dmSerifText(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _fetchTasksForSelectedDay(selectedDay);
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            if (_selectedDay != null)
              Expanded(
                child: _buildTaskListView(_selectedDay!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListView(DateTime selectedDay) {
    return ListView.builder(
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
                      'Service Name: ${orderDetails.service_name ?? ''}',
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
                                    'Completed',
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
    );
  }

  void _fetchTasksForSelectedDay(DateTime selectedDay) async {
    try {
      int? employeeCode = SharedPrefs.employeeCode;
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
      final response = await orderBookingServices.getListOrderDetailsByWorkDate(
          formattedDate, employeeCode!);
      if (response.statusCode == 200) {
        setState(() {
          orderDetailsList = parseOrderDetailsList(response.body);
        });
      } else {
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['errMessage'] ??
            'Failed to load tasks for selected day. Please try again later.';
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  List<OrderDetailsModel> parseOrderDetailsList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<OrderDetailsModel>((json) => OrderDetailsModel.fromJson(json))
        .toList();
  }
}
