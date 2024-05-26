// ignore_for_file: unused_element

import 'dart:convert';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/pages/task_view_employee/task_view_employee_detail.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SchudleMainPage extends StatefulWidget {
  const SchudleMainPage({super.key});

  @override
  State<SchudleMainPage> createState() => _SchudleMainPageState();
}

class _SchudleMainPageState extends State<SchudleMainPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<OrderDetailsModel> orderDetailsList = [];
  final orderBookingServices = OrderBookingServices();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Table Calendar',
            style: GoogleFonts.merriweather(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TableCalendar(
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
                todayBuilder: (context, date, events) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: GoogleFonts.tiroTamil(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
                formatButtonVisible: false,
                titleCentered: true,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
                weekendStyle: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColor.blue,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColor.grey,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: AppColor.white),
                todayTextStyle: TextStyle(color: AppColor.white),
              ),
              firstDay: DateTime(2020),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  final selectedDate = DateTime.utc(
                      selectedDay.year, selectedDay.month, selectedDay.day);
                  _selectedDay = selectedDate;
                  _focusedDay = focusedDay;
                  _fetchTasksForSelectedDay(selectedDate);
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
        final DateTime? workDateWithOneDay =
            addOneDay(parseDate(orderDetails.work_date));
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskViewEmployeeDetail(
                orderDetails: orderDetails,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(
                  color: AppColor.grey,
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
                            'Status',
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
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blue,
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
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDay.toLocal());
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

  Future<Map<DateTime, List<dynamic>>> _fetchEvents(DateTime day) async {
    Map<DateTime, List<dynamic>> events = {};
    try {
      int? employeeCode = SharedPrefs.employeeCode;
      String formattedDate = DateFormat('yyyy-MM-dd').format(day.toLocal());
      final response = await orderBookingServices.getListOrderDetailsByWorkDate(
          formattedDate, employeeCode!);
      if (response.statusCode == 200) {
        List<OrderDetailsModel> orders = parseOrderDetailsList(response.body);
        if (orders.isNotEmpty) {
          events[day] = orders;
        }
      } else {
        // Xử lý lỗi nếu có
      }
    } catch (error) {
      print('Error fetching tasks: $error');
    }
    return events;
  }

  bool _hasTasksOnDate(DateTime date) {
    final selectedDate = DateTime.utc(date.year, date.month, date.day);
    final foundTasks = orderDetailsList.any((task) {
      final taskDate = parseDate(task.work_date);
      return isSameDay(taskDate, selectedDate);
    });
    return foundTasks;
  }

  List<OrderDetailsModel> parseOrderDetailsList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<OrderDetailsModel>((json) => OrderDetailsModel.fromJson(json))
        .toList();
  }
}
