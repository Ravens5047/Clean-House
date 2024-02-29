import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class SuccessfulPayment extends StatefulWidget {
  const SuccessfulPayment({super.key});

  @override
  State<SuccessfulPayment> createState() => _SuccessfulPaymentState();
}

class _SuccessfulPaymentState extends State<SuccessfulPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Successfully Booking',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: AppColor.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Thank you for using our service !',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColor.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Ikonate(
                      Ikonate.home_alt,
                      color: AppColor.blue,
                      height: 40.0,
                    ),
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  const Ikonate(
                    Ikonate.calendar_event,
                    color: AppColor.blue,
                    height: 40.0,
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  const Ikonate(
                    Ikonate.inbox,
                    color: AppColor.blue,
                    height: 40.0,
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const InformationPerson()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Ikonate(
                      Ikonate.user,
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
    );
  }
}
