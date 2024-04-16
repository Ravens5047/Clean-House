import 'package:bottom_picker/resources/time.dart';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/model/request/order_details_request_model.dart';
import 'package:capstone2_clean_house/pages/booking_services/booking_services_successfull.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({
    super.key,
    required this.selectedTime,
    required this.selectedDate,
    this.selectedHouse,
    this.selectedArea,
    required this.address,
    required this.fullname,
    required this.note,
    required this.total_price,
    required this.phone_number,
    required this.name_service,
    required this.service_id,
    required this.static_id,
  });

  final Time selectedTime;
  final DateTime selectedDate;
  final int? selectedHouse;
  final int? selectedArea;
  final String address;
  final String fullname;
  final String phone_number;
  final String name_service;
  final String note;
  final int total_price;
  final int service_id;
  final int static_id;

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  String? selectedLocation;
  final List<String> locations = [
    'Cash',
    'VNPAY',
  ];
  TextEditingController moneyController = TextEditingController();
  int? selectedHouse;
  int? selectedArea;
  AccountService accountService = AccountService();
  late int userId;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedHouse = widget.selectedHouse;
    selectedArea = widget.selectedArea;
  }

  String getHouseType(int index) {
    switch (index) {
      case 0:
        return 'House / Town House';
      case 1:
        return 'Apartment';
      case 2:
        return 'Villas';
      default:
        return '';
    }
  }

  String getArea(int index) {
    switch (index) {
      case 0:
        return 'Max 15m²';
      case 1:
        return 'Max 25m²';
      case 2:
        return 'Max 40m²';
      case 3:
        return 'Max 60m²';
      case 4:
        return 'Max 80m²';
      case 5:
        return 'Max 100m²';
      default:
        return '';
    }
  }

  Future<void> _bookOrderDetails() async {
    try {
      OrderDetailsRequest orderDetails = OrderDetailsRequest(
        name_service: widget.name_service,
        status_id: 1,
        sub_total_price: widget.total_price.toDouble(),
        service_id: widget.service_id,
        note: widget.note,
        unit_price: widget.total_price.toDouble(),
        address_order: widget.address,
        full_name: widget.fullname,
        phone_number: widget.phone_number,
        houseType: getHouseType(selectedHouse!),
        area: getArea(selectedArea!),
        work_date: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
        start_time:
            '${widget.selectedTime.hours.toString().padLeft(2, '0')}:${widget.selectedTime.minutes.toString().padLeft(2, '0')}',
      );
      final response =
          await OrderBookingServices().orderBookingDetails(orderDetails);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BookingServicesSuccessful(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Bill',
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Type Service:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      widget.name_service,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Working Location',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: double.infinity,
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
                        Text(
                          'Full Name: ${widget.fullname}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Address: ${widget.address}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Phone : ${widget.phone_number}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    const Text(
                      'House Type',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      selectedHouse != null
                          ? getHouseType(selectedHouse!)
                          : "Not Selected",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text(
                      'Area: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      selectedArea != null
                          ? getArea(selectedArea!)
                          : "Not Selected",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text(
                      'Work date: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text(
                      'Start Time: ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.selectedTime.hours.toString().padLeft(2, '0')}:${widget.selectedTime.minutes.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.blue,
                  thickness: 2.0,
                  indent: 50.0,
                  endIndent: 50.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text(
                      'Totals ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${NumberFormat('#,##0', 'en_US').format(widget.total_price)} VND',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Note for the Tasker',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 100.0,
                  width: double.infinity,
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
                        Text(
                          widget.note,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45.0,
                ),
                AppElevatedButton.normal1(
                  onPressed: _bookOrderDetails,
                  color: Colors.blue,
                  borderColor: AppColor.grey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  text: 'Booking',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
