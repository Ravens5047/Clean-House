import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class AppDialog {
  AppDialog._();

  static void dialog(
    BuildContext context, {
    required title,
    required content,
    Function()? action,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: AppColor.black,
            ),
          ),
        ),
        content: Row(
          children: [
            Expanded(
              child: Text(
                content,
                style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppElevatedButton.smallOutline(
                fontSize: 15.0,
                borderColor: AppColor.grey,
                onPressed: () {
                  action?.call();
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                text: 'Yes',
              ),
              const SizedBox(
                width: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: AppElevatedButton.smallOutline(
                  fontSize: 15.0,
                  borderColor: AppColor.grey,
                  onPressed: () => Navigator.pop(context),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  text: 'No',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
