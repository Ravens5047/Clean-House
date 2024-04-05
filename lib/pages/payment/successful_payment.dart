import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class SuccessfulPayment extends StatefulWidget {
  const SuccessfulPayment({
    super.key,
    required this.result,
  });

  final String result;

  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: widget.result == "00"
                    ? const Column(
                        children: [
                          Text(
                            "Successful Payment",
                            style: TextStyle(
                              color: AppColor.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Thank your for your successful payment",
                            style: TextStyle(
                              color: AppColor.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        "Fail Payment!!!",
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Ikonate(
                        Ikonate.home_alt,
                        color: AppColor.blue,
                        height: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
