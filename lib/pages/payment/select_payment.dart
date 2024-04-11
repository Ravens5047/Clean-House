import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/payment/successful_payment.dart';
import 'package:capstone2_clean_house/pages/vnpay/payment_screen_vnpay_local.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({
    super.key,
    required this.total_price,
  });

  final int total_price;

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  TextEditingController moneyController = TextEditingController();
  String? selectedLocation;
  final List<String> locations = [
    'Cash',
    'VNPAY',
  ];

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
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              height: 55.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColor.blue.withOpacity(0.4),
                border: Border.all(
                  width: 1.0,
                  color: AppColor.black.withOpacity(0.8),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButton<String>(
                dropdownColor: AppColor.blue.withOpacity(0.4),
                value: selectedLocation,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.black,
                  size: 30.0,
                ),
                elevation: 16,
                style: const TextStyle(
                  color: AppColor.white,
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
            const SizedBox(height: 20.0),
            Center(
              child: AppElevatedButton.normal1(
                text: 'Booking',
                onPressed: () {
                  if (selectedLocation == 'VNPAY') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VnpayScreenPayment1(
                            money: widget.total_price.toString()),
                      ),
                    );
                  } else if (selectedLocation == 'Cash') {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SuccessfulPayment(
                                result: '00',
                              )),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.blue,
                      content: Center(
                        child: Text(
                          "Please Select Payment Method",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ));
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
