import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class BounderInfo extends StatelessWidget {
  BounderInfo({
    super.key,
    Color? color,
    required this.text,
    this.textColor = AppColor.black,
    this.fontSize = 19.0,
    Color? borderColor,
    this.height = 70.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    BorderRadius? borderRadius,
  })  : color = color ?? AppColor.white.withOpacity(0.1),
        borderColor = borderColor ?? AppColor.black.withOpacity(0.35),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  final Color color;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

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
          border: Border.all(color: borderColor, width: 3),
          borderRadius: borderRadius,
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
