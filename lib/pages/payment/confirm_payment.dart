import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/vnpay/payment_screen_vnpay.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm And Payment',
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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '162/5 Đống Đa, Phường Thuận Phước, Quận Hải Châu, Đà Nẵng',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        'Nguyễn Hoàng Hưng',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        'Phone: 0906436495',
                        style: TextStyle(
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
                height: 30.0,
              ),
              const Row(
                children: [
                  Text(
                    'House Type',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'House/Town House',
                    style: TextStyle(
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
              const Row(
                children: [
                  Text(
                    'Area: ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '80m²',
                    style: TextStyle(
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
              const Row(
                children: [
                  Text(
                    'Work date: ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '2/4/2024',
                    style: TextStyle(
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
              const Row(
                children: [
                  Text(
                    'Start Time: ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '17:54 PM',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                'Note for the Tasker: ',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 25.0,
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
                  hint: const Text('Select Payment Method'),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue;
                    });
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  items:
                      locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Row(
                children: [
                  Text(
                    'Totals ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '880,000 VND ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: moneyController,
                  decoration: InputDecoration(
                    prefixIconColor: AppColor.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Cost You Will Payment",
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: AppElevatedButton.normal1(
                  text: 'Payment',
                  onPressed: () {
                    int? money = int.tryParse(moneyController.text);
                    if (money == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Số tiền không hợp lệ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PayScreen(money: moneyController.text),
                      ),
                    );
                  },
                ),
              ),
              // const Spacer(),
              // AppElevatedButton.normal1(
              //   onPressed: () {
              //     Navigator.of(context).pushAndRemoveUntil(
              //       MaterialPageRoute(
              //           builder: (context) => SuccessfulPayment(
              //                 result: "0",
              //               )),
              //       (Route<dynamic> route) => false,
              //     );
              //   },
              //   text: 'Booking',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
