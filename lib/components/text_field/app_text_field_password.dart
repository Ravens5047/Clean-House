import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class AppTextFieldPassword extends StatefulWidget {
  const AppTextFieldPassword({
    super.key,
    this.controller,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.textInputAction,
    this.hintext,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hintext;
  final BorderRadius borderRadius;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<AppTextFieldPassword> createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        );
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.4),
        borderRadius: widget.borderRadius,
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlignVertical: const TextAlignVertical(y: 0.0),
        controller: widget.controller,
        obscureText: !showPassword,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        style: AppStyle.h16Normal.copyWith(color: AppColor.brown),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: outlineInputBorder(AppColor.red),
          focusedBorder: outlineInputBorder(AppColor.blue),
          enabledBorder: outlineInputBorder(AppColor.white),
          hintText: widget.hintext,
          hintStyle: AppStyle.h16Normal.copyWith(
            color: AppColor.black.withOpacity(0.5),
          ),
          suffixIcon: GestureDetector(
            onTap: () => setState(() => showPassword = !showPassword),
            child: Icon(
              showPassword
                  ? Icons.remove_red_eye_rounded
                  : Icons.remove_red_eye_outlined,
              color: showPassword ? AppColor.blue : AppColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
