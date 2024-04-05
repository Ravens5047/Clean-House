import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class ForgotMail extends StatefulWidget {
  const ForgotMail({super.key});

  @override
  State<ForgotMail> createState() => _ForgotMailState();
}

class _ForgotMailState extends State<ForgotMail> {
  final authServices = APIService();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: MediaQuery.of(context).padding.top + 30.0),
              child: Column(
                children: [
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'Enter your email for the verification process.',
                    style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    'We will send 3 digits code to your email.',
                    style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: AppTextField(
                      controller: emailController,
                      hintext: 'Enter Email',
                      validator: Validator.emailValidator.call,
                      // onFieldSubmitted: (_) => _sendOtp(),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(height: 10.0),
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
                    height: 400.0,
                  ),
                  AppElevatedButton(
                    onPressed: () {},
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
