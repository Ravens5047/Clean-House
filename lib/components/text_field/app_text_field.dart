import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.height = 100.0,
    this.onTextChanged,
    this.errorText,
    this.inputFormatters,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String hintext;
  final BorderRadius borderRadius;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final double height;
  final Function(String)? onTextChanged;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

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
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: height / 6),
          border: outlineInputBorder(AppColor.red),
          focusedBorder: outlineInputBorder(AppColor.blue),
          enabledBorder: outlineInputBorder(AppColor.white),
          errorBorder: outlineInputBorder(Colors.red),
          errorStyle: const TextStyle(color: Colors.red),
          hintText: hintext,
          hintStyle: AppStyle.h16Normal.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
