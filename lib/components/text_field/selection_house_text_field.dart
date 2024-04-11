import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class SelectionHouseTextField extends StatelessWidget {
  const SelectionHouseTextField({
    super.key,
    // this.controller,
    this.focusNode,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.isSelected = false,
    this.controller,
    this.readOnly = false,
  });

  // final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final Icon? prefixIcon;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final bool isSelected;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        );
    return Stack(
      children: [
        Container(
          height: 48.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadow,
                offset: Offset(0.0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        TextFormField(
          // controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          validator: validator,
          readOnly: readOnly,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.6),
            filled: true,
            fillColor: Colors.white,
            border: outlineInputBorder(AppColor.orange),
            focusedBorder: outlineInputBorder(AppColor.orange),
            enabledBorder: outlineInputBorder(AppColor.grey),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColor.black),
            labelText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
