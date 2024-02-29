import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/auth/forgot_password/forgot_confirm_password.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class ForgotDigits extends StatefulWidget {
  const ForgotDigits({super.key});

  @override
  State<ForgotDigits> createState() => _ForgotDigitsState();
}

class _ForgotDigitsState extends State<ForgotDigits> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(top: MediaQuery.of(context).padding.top + 30.0),
            child: Column(
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 48, 7, 233),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Enter 3 Digits Code',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Enter the 3 digits code that you received on',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
                Text(
                  'your email.',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
                const SizedBox(
                  height: 90.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOtpBox(),
                    _buildOtpBox(),
                    _buildOtpBox(),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Resend code',
                      style: AppStyle.h18Normal.copyWith(color: AppColor.grey)),
                ),
                const SizedBox(
                  height: 350.0,
                ),
                AppElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ForgotConfirmPassword(),
                    ),
                  ),
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
Widget _buildOtpBox() {
  // ignore: sized_box_for_whitespace
  return Container(
    width: 60.0,
    height: 60.0,
    child: TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
