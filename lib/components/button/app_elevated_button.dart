import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  AppElevatedButton({
    super.key,
    this.isDisable = false,
    this.onPressed,
    Color? color,
    required this.text,
    this.textColor = AppColor.white,
    this.fontSize = 19.0,
    Color? borderColor,
    this.icon,
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    // this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  })  : color = color ?? AppColor.blue.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.black.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0),
        splashColor = splashColor ?? AppColor.red.withOpacity(0.6),
        highlightColor = highlightColor ?? AppColor.green.withOpacity(0.6);

  AppElevatedButton.normal1({
    super.key,
    this.isDisable = false,
    this.onPressed,
    Color? color,
    required this.text,
    this.textColor = AppColor.white,
    this.fontSize = 19.0,
    Color? borderColor,
    this.icon,
    this.height = 60.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    // this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  })  : color = color ?? AppColor.blue.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.blue.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0),
        splashColor = splashColor ?? AppColor.yellow.withOpacity(0.6),
        highlightColor = highlightColor ?? AppColor.green.withOpacity(0.6);

  AppElevatedButton.small({
    super.key,
    this.isDisable = false,
    this.onPressed,
    Color? color,
    required this.text,
    this.textColor = AppColor.white,
    this.fontSize = 14.6,
    Color? borderColor,
    this.icon,
    this.height = 38.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    // this.borderRadius = const BorderRadius.all(Radius.circular(8.6)),
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  })  : color = color ?? AppColor.red.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.red.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(8.6),
        splashColor = splashColor ?? AppColor.yellow.withOpacity(0.6),
        highlightColor = highlightColor ?? AppColor.green.withOpacity(0.6);

  AppElevatedButton.outline({
    super.key,
    this.isDisable = false,
    this.onPressed,
    Color? color,
    required this.text,
    this.textColor = AppColor.black,
    this.fontSize = 19.0,
    Color? borderColor,
    this.icon,
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    // this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  })  : color = color ?? AppColor.white.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.grey.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(10.0),
        splashColor = splashColor ?? AppColor.blue.withOpacity(0.6),
        highlightColor = highlightColor ?? AppColor.green.withOpacity(0.6);

  AppElevatedButton.smallOutline({
    super.key,
    this.isDisable = false,
    this.onPressed,
    Color? color,
    required this.text,
    this.textColor = AppColor.black,
    this.fontSize = 23.0,
    this.icon,
    Color? borderColor,
    this.height = 38.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0),
    // this.borderRadius = const BorderRadius.all(Radius.circular(8.6)),
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? highlightColor,
  })  : color = color ?? AppColor.white.withOpacity(0.98),
        borderColor = borderColor ?? AppColor.blue.withOpacity(0.98),
        borderRadius = borderRadius ?? BorderRadius.circular(8.6),
        splashColor = splashColor ?? AppColor.red.withOpacity(0.6),
        highlightColor = highlightColor ?? AppColor.green.withOpacity(0.6);

  final Function()? onPressed;
  final Color color;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
  final double height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final bool isDisable;
  final Color splashColor;
  final Color highlightColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: isDisable ? null : onPressed,
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Ink(
          padding: padding,
          height: height,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor, width: 1.2),
            borderRadius: borderRadius,
            boxShadow: const [
              BoxShadow(
                color: AppColor.shadow,
                offset: Offset(0.0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 4.6),
              ],
              isDisable
                  ? Center(
                      child: SizedBox.square(
                        dimension: height - 22.0,
                        child: CircularProgressIndicator(
                          color: textColor,
                          strokeWidth: 2.2,
                        ),
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
