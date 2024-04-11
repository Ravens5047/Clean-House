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
    this.validator,
    this.onFieldSubmitted,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String hintext;
  final BorderRadius borderRadius;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        );
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.4),
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        validator: validator,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: outlineInputBorder(AppColor.red),
          focusedBorder: outlineInputBorder(AppColor.blue),
          enabledBorder: outlineInputBorder(AppColor.white),
          hintText: hintext,
          hintStyle: AppStyle.h16Normal.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
