import 'package:bottom_picker/resources/time.dart';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/model/request/order_details_request_model.dart';
import 'package:capstone2_clean_house/pages/notifications/notification_service.dart';
import 'package:capstone2_clean_house/pages/payment/successful_payment.dart';
import 'package:capstone2_clean_house/pages/vnpay/payment_screen_vnpay_local.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({
    super.key,
    this.total_price,
    this.selectedTime,
    this.selectedDate,
    this.selectedHouse,
    this.selectedArea,
    this.address,
    this.fullname,
    this.note,
    this.phone_number,
    this.name_service,
    this.service_id,
    this.static_id,
    this.estimated_time,
    this.payment,
    this.notifications,
  });

  final double? total_price;
  final Time? selectedTime;
  final DateTime? selectedDate;
  final int? selectedHouse;
  final int? selectedArea;
  final String? address;
  final String? fullname;
  final String? phone_number;
  final String? name_service;
  final String? note;
  final int? service_id;
  final int? static_id;
  final String? estimated_time;
  final String? payment;
  final List<Map<String, String>>? notifications;

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  TextEditingController moneyController = TextEditingController();
  String? selectedLocation;
  int? selectedHouse;
  int? selectedArea;
  final List<String> locations = [
    'Cash',
    'VNPAY',
  ];
  final List<Map<String, String>> notifications = [];

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
      int? userId = SharedPrefs.user_id;
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not logged in.'),
        ));
        return;
      }
      OrderDetailsRequest orderDetails = OrderDetailsRequest(
        name_service: widget.name_service,
        status_id: 1,
        sub_total_price: widget.total_price?.toDouble(),
        service_id: widget.service_id,
        note: widget.note,
        unit_price: widget.total_price?.toDouble(),
        address_order: widget.address,
        full_name: widget.fullname,
        phone_number: widget.phone_number,
        houseType: getHouseType(widget.selectedHouse!),
        area: getArea(widget.selectedArea!),
        work_date: DateFormat('yyyy-MM-dd').format(widget.selectedDate!),
        start_time:
            '${widget.selectedTime!.hours.toString().padLeft(2, '0')}:${widget.selectedTime!.minutes.toString().padLeft(2, '0')}',
        estimated_time: widget.estimated_time,
        user_id: userId,
        payment: selectedLocation,
        status_payment:
            selectedLocation == 'VNPAY' ? 'Successful Payment' : 'Processing',
        notification: notifications.toString(),
      );
      final response =
          await OrderBookingServices().orderBookingDetails(orderDetails);
      if (response.statusCode == 200) {
        addNotification(
            'Booking successful!', 'We will confirm your booking shortly.');
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

  void showCustomSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.blue,
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Center(
          child: Text(
            "Please Select Payment Method",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
            ),
          ),
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void addNotification(String title, String message) {
    setState(() {
      notifications.add({
        'title': title,
        'message': message,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: GoogleFonts.podkova(
            color: AppColor.black,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 200.0,
                child: Lottie.asset('assets/payment.json'),
              ),
            ),
            const Text(
              'Payment Method ',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              height: 55.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.7),
                border: Border.all(
                  width: 1.0,
                  color: AppColor.black.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButton<String>(
                dropdownColor: Colors.blue.withOpacity(0.4),
                value: selectedLocation,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.black,
                  size: 30.0,
                ),
                elevation: 16,
                style: TextStyle(
                  color: Colors.white.withOpacity(1.0),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                hint: const Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                ),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
                borderRadius: BorderRadius.circular(16.0),
                items: locations.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                const Text(
                  'Totals ',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
                const Spacer(),
                Text(
                  '${NumberFormat('#,##0', 'en_US').format(widget.total_price)} VND',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textAlign: TextAlign.center,
                readOnly: true,
                controller: moneyController,
                decoration: InputDecoration(
                  prefixIconColor: AppColor.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText:
                      '${NumberFormat('#,##0', 'en_US').format(widget.total_price)} VND',
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: AppElevatedButton.normal1(
                color: Colors.blue,
                borderColor: AppColor.grey,
                text: 'Payment',
                onPressed: () async {
                  if (selectedLocation == 'VNPAY') {
                    await NotificationServices.showNotification(
                      title: 'Booking successful!',
                      body: 'We will confirm your booking shortly.',
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VnpayScreenPayment1(
                          money: widget.total_price.toString(),
                          selectedTime: widget.selectedTime,
                          selectedDate: widget.selectedDate,
                          selectedHouse: widget.selectedHouse,
                          selectedArea: widget.selectedArea,
                          address: widget.address,
                          fullname: widget.fullname,
                          phone_number: widget.phone_number,
                          name_service: widget.name_service,
                          note: widget.note,
                          total_price: widget.total_price,
                          service_id: widget.service_id,
                          static_id: widget.static_id,
                          estimated_time: widget.estimated_time,
                          payment: selectedLocation,
                          status_payment: selectedLocation == 'VNPAY'
                              ? 'Successfull Payment'
                              : 'Processing',
                          notifications: notifications,
                        ),
                      ),
                    );
                  } else if (selectedLocation == 'Cash') {
                    _bookOrderDetails();
                    await NotificationServices.showNotification(
                      title: 'Booking successful!',
                      body: 'We will confirm your booking shortly.',
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => SuccessfulPayment(
                                result: '00',
                                payment: 'Cash',
                                status_payment: 'Processing',
                                notifications: notifications,
                              )),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    showCustomSnackBar(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
