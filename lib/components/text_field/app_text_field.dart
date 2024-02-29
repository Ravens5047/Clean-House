import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.hintext,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String hintext;
  final BorderRadius borderRadius;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.4),
        borderRadius: borderRadius,
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
          hintText: hintext,
          hintStyle: AppStyle.h16Normal.copyWith(color: AppColor.grey),
        ),
      ),
    );
  }
}
