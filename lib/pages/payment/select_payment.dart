import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/payment/successful_payment.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({super.key});

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  String? selectedLocation;
  final List<String> locations = [
    'Cash',
    'Momo',
    'Credit, debit card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            color: AppColor.blue,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Container(
              height: 55.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColor.blue.withOpacity(0.5),
                border: Border.all(
                  width: 1.2,
                  color: AppColor.black.withOpacity(0.8),
                ),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.shadow,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: DropdownButton<String>(
                dropdownColor: AppColor.blue.withOpacity(0.5),
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
                hint: const Text('Select Payment Method'),
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue;
                  });
                },
                items: locations.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 150.0,
              height: 90.0,
              child: AppElevatedButton.normal1(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SuccessfulPayment()),
                    (Route<dynamic> route) => false,
                  );
                },
                text: 'Booking',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
