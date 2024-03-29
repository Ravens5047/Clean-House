import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class ContainerCircle extends StatelessWidget {
  ContainerCircle({
    this.isSelected = false,
    super.key,
    Color? color,
    required this.text,
    this.textColor = AppColor.black,
    this.fontSize = 19.0,
    Color? borderColor,
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    BorderRadius? borderRadius,
    this.onPressed,
  })  : color = color ?? const Color.fromARGB(255, 74, 180, 241),
        borderColor = borderColor ?? const Color.fromARGB(255, 74, 180, 241),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  ContainerCircle.text1({
    this.isSelected = false,
    super.key,
    Color? color,
    required this.text,
    this.textColor = AppColor.white,
    this.fontSize = 19.0,
    Color? borderColor,
    this.height = 80.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    BorderRadius? borderRadius,
    this.onPressed,
  })  : color = color ?? AppColor.blue.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.blue.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0);

  final Color color;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: padding,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : color,
          border: Border.all(
              color: isSelected ? Colors.white : borderColor, width: 5),
          borderRadius: borderRadius,
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
