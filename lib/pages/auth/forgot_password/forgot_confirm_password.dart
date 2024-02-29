import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/material.dart';

class ForgotConfirmPassword extends StatefulWidget {
  const ForgotConfirmPassword({super.key});

  @override
  State<ForgotConfirmPassword> createState() => _ForgotConfirmPasswordState();
}

class _ForgotConfirmPasswordState extends State<ForgotConfirmPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                const Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Set the new password for your account so ',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
                Text(
                  'you can login and access all the futures.',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
                const SizedBox(height: 50.0),
                AppTextFieldPassword(
                  controller: passwordController,
                  hintext: 'Password',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16.0),
                AppTextFieldPassword(
                  controller: confirmPasswordController,
                  hintext: 'Confirm Password',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Return Sign In',
                      style: TextStyle(
                        color: AppColor.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 380.0,
                ),
                AppElevatedButton(
                  text: 'Reset Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
