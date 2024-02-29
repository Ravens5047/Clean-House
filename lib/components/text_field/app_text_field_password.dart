import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class AppTextFieldPassword extends StatefulWidget {
  const AppTextFieldPassword({
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
  State<AppTextFieldPassword> createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.4),
        borderRadius: widget.borderRadius,
      ),
      child: TextField(
        textAlignVertical: const TextAlignVertical(y: 0.0),
        controller: widget.controller,
        obscureText: !showPassword,
        textInputAction: widget.textInputAction,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
          hintText: widget.hintext,
          hintStyle: AppStyle.h16Normal.copyWith(color: AppColor.grey),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => showPassword = !showPassword),
            child: Icon(
              showPassword
                  ? Icons.remove_red_eye_rounded
                  : Icons.remove_red_eye_outlined,
              color: showPassword ? AppColor.brown : AppColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
