import 'dart:convert';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/drawer_menu/drawer_menu_employee.dart';
import 'package:capstone2_clean_house/pages/task_view_employee/task_view_employee_detail.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:capstone2_clean_house/services/remote/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:intl/intl.dart';

enum FilterCriteria {
  ByDate,
  ByService,
  ByTotal,
  ByWorkDate,
}

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({super.key});

  @override
  State<HomeScreenEmployee> createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
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
    _getListOrderDetailsEmp();
    super.initState();
  }

  void _getListOrderDetailsEmp() {
    orderBookingServices.getListOrderDetails().then((response) {
      if (response.statusCode == 200) {
        List<OrderDetailsModel> tempListOrderDetails = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          OrderDetailsModel orderDetails = OrderDetailsModel.fromJson(data);
          tempListOrderDetails.add(orderDetails);
        }
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

  void _searchServices(String name_service) {
    orderBookingServices.searchServicesBooking(name_service).then((response) {
      if (response.statusCode == 200) {
        List<OrderDetailsModel> tempList = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          OrderDetailsModel service = OrderDetailsModel.fromJson(data);
          tempList.add(service);
        }
        setState(() {
          orderDetailsList = tempList;
        });
      } else {
        print('Failed to search services booking');
      }
      if (orderDetailsList.isEmpty) {
        _reloadUI();
      }
    }).catchError((onError) {
      print('Error occurred: $onError');
    });
  }

  void _reloadUI() {
    _getListOrderDetailsEmp();
  }

  void _handleFilter() async {
    final FilterCriteria? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Filter Options')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('By Date'),
                onTap: () {
                  Navigator.pop(context, FilterCriteria.ByDate);
                },
              ),
              ListTile(
                title: const Text('By Service'),
                onTap: () {
                  Navigator.pop(context, FilterCriteria.ByService);
                },
              ),
              ListTile(
                title: const Text('By Total'),
                onTap: () {
                  Navigator.pop(context, FilterCriteria.ByTotal);
                },
              ),
              ListTile(
                title: const Text('By Work Date'),
                onTap: () {
                  Navigator.pop(context, FilterCriteria.ByWorkDate);
                },
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        currentFilter = result;
      });
    }
  }

  void _handleSort() {
    setState(() {
      if (currentFilter != FilterCriteria.ByService) {
        isAscending = !isAscending;
        orderDetailsList
            .sort((a, b) => a.name_service!.compareTo(b.name_service!));
        currentFilter = FilterCriteria.ByService;
      } else {
        isAscending = !isAscending;
        orderDetailsList
            .sort((a, b) => b.name_service!.compareTo(a.name_service!));
        currentFilter = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Home',
          style: GoogleFonts.dmSerifText(
            fontSize: 22.0,
            fontWeight: FontWeight.w200,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _handleFilter();
            },
          ),
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
      drawer: DrawerMenuEmployee(
        appUser: appUser,
        user_id: appUser.user_id ?? 0,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    _searchServices(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderDetailsList.length,
                  itemBuilder: (context, index) {
                    final orderDetails = orderDetailsList[index];
                    if (currentFilter == FilterCriteria.ByService) {
                      // Logic lọc theo name_service
                      // Đảm bảo rằng orderDetails có name_service trước khi so sánh
                    } else if (currentFilter == FilterCriteria.ByTotal) {
                      // Logic lọc theo total
                      // Đảm bảo rằng orderDetails có total trước khi so sánh
                    } else if (currentFilter == FilterCriteria.ByWorkDate) {
                      // Logic lọc theo work_date
                      // Đảm bảo rằng orderDetails có work_date trước khi so sánh
                    } else {
                      // Không có bộ lọc được chọn, hiển thị tất cả các dữ liệu
                    }
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
