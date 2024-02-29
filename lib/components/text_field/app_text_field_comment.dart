import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class AppTextFieldComment extends StatelessWidget {
  const AppTextFieldComment({
    super.key,
    this.controller,
    required this.hintext,
    this.borderRadius = const BorderRadius.all(Radius.circular(15.0)),
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
        color: const Color.fromARGB(255, 134, 128, 128).withOpacity(0.4),
        borderRadius: borderRadius,
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          border: InputBorder.none,
          hintText: hintext,
          hintStyle: AppStyle.h16Normal.copyWith(
            color: const Color.fromARGB(255, 44, 38, 38),
          ),
        ),
      ),
    );
  }
}
