import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class SelectionTime extends StatelessWidget {
  SelectionTime({
    super.key,
    Color? color,
    required this.text,
    this.textColor = AppColor.black,
    this.fontSize = 15.0,
    Color? borderColor,
    this.height = 70.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    BorderRadius? borderRadius,
    this.isSelected = false,
  })  : color = color ?? AppColor.white.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.blue.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(8.0);

  final Color color;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: padding,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: isSelected ? AppColor.blue : AppColor.grey, width: 1),
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColor.blue : AppColor.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
