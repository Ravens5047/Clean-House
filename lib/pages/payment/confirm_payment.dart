import 'package:bottom_picker/resources/time.dart';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/booking_services/booking_services_successfull.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
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
      body: SingleChildScrollView(
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
                      fontWeight: FontWeight.w400,
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
                      const Text(
                        'Phone: 0906436495',
                        style: TextStyle(
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
              const Divider(
                color: AppColor.blue,
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
                height: 20.0,
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
                height: 100.0,
              ),
              AppElevatedButton.normal1(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingServicesSuccessful(),
                    ),
                  );
                },
                borderColor: AppColor.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                text: 'Booking',
              ),

              // const SizedBox(
              //   height: 25.0,
              // ),
              // const Text(
              //   'Payment Method ',
              //   style: TextStyle(
              //     fontSize: 14.0,
              //     fontWeight: FontWeight.w500,
              //     color: AppColor.black,
              //   ),
              // ),
              // const SizedBox(
              //   height: 25.0,
              // ),
              // Container(
              //   height: 55.0,
              //   padding: const EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     color: AppColor.blue.withOpacity(0.4),
              //     border: Border.all(
              //       width: 1.0,
              //       color: AppColor.black.withOpacity(0.8),
              //     ),
              //     borderRadius: BorderRadius.circular(30.0),
              //   ),
              //   child: DropdownButton<String>(
              //     dropdownColor: AppColor.blue.withOpacity(0.4),
              //     value: selectedLocation,
              //     icon: const Icon(
              //       Icons.arrow_drop_down,
              //       color: AppColor.black,
              //       size: 30.0,
              //     ),
              //     elevation: 16,
              //     style: const TextStyle(
              //       color: AppColor.white,
              //       fontSize: 18.0,
              //       fontWeight: FontWeight.w500,
              //     ),
              //     hint: const Text(
              //       'Select Payment Method',
              //       style: TextStyle(
              //         fontSize: 17.0,
              //         fontWeight: FontWeight.w400,
              //         color: AppColor.black,
              //       ),
              //     ),
              //     isExpanded: true,
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         selectedLocation = newValue;
              //       });
              //     },
              //     borderRadius: BorderRadius.circular(16.0),
              //     items:
              //         locations.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30.0,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       'Totals ',
              //       style: TextStyle(
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.w500,
              //         color: AppColor.black,
              //       ),
              //     ),
              //     const Spacer(),
              //     Text(
              //       '${NumberFormat('#,##0', 'en_US').format(widget.total_price)} VND',
              //       style: const TextStyle(
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.w500,
              //         color: AppColor.black,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     textAlign: TextAlign.center,
              //     readOnly: true,
              //     controller: moneyController,
              //     decoration: InputDecoration(
              //       prefixIconColor: AppColor.red,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       hintText:
              //           '${NumberFormat('#,##0', 'en_US').format(widget.total_price)} VND',
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20.0),
              // Center(
              //   child: AppElevatedButton.normal1(
              //     text: 'Booking',
              //     onPressed: () {
              //       if (selectedLocation == 'VNPAY') {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => VnpayScreenPayment1(
              //                 money: widget.total_price.toString()),
              //           ),
              //         );
              //       } else if (selectedLocation == 'Cash') {
              //         Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(
              //               builder: (context) => const SuccessfulPayment(
              //                     result: '00',
              //                   )),
              //           (Route<dynamic> route) => false,
              //         );
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           backgroundColor: Colors.blue,
              //           content: Center(
              //             child: Text(
              //               "Please Select Payment Method",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 12.0,
              //               ),
              //             ),
              //           ),
              //         ));
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
