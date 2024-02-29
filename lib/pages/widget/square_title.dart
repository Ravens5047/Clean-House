import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  const SquareTitle({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.white,
        ),
        borderRadius: BorderRadius.circular(16.0),
        color: AppColor.white,
        boxShadow: const [
          BoxShadow(
            color: AppColor.black,
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Text(
            'Google',
            style: TextStyle(
              fontSize: 20.0,
              color: AppColor.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
