import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class BookingServicesSuccessful extends StatefulWidget {
  const BookingServicesSuccessful({super.key});

  @override
  State<BookingServicesSuccessful> createState() =>
      _BookingServicesSuccessfulState();
}

class _BookingServicesSuccessfulState extends State<BookingServicesSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset(
            'assets/successfully.json',
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.blue,
              highlightColor: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Thank you for using our service',
                    style: AppStyle.h18Normal.copyWith(
                      color: AppColor.grey,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Clean House Services!',
                    style: AppStyle.h18Normal.copyWith(
                      color: AppColor.grey,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
            child: SizedBox(
              height: 60.0,
              width: 60.0,
              child: Lottie.asset(
                'assets/house_icon.json',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
