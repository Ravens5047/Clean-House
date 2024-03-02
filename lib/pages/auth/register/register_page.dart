import 'dart:developer';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/auth/register/verification_code_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/services/remote/body/register_body.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  late bool isCheck;
  AuthServices authServices = AuthServices();
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> _sendOtp() async {
    if (formKey.currentState!.validate() == false) {
      return;
    }

    RegisterBody body = RegisterBody()
      ..name = nameController.text.trim()
      ..email = emailController.text.trim()
      ..password = passwordController.text;
    // ..phone = phoneController.text.trim();

    String email = emailController.text.trim();

    authServices.sendOtp(email).then((response) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        showTopSnackBar(
          context,
          const TDSnackBar.success(message: 'Otp has been sent, check email'),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerificationCodePage(
              registerBody: body,
            ),
          ),
        );
      } else {
        showTopSnackBar(
          context,
          TDSnackBar.error(
            message: ('${data['message']}'),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = AppStyle.h16Normal;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 64.0, bottom: 72.0),
            children: [
              const Text(
                'Creater Your Account',
                style: TextStyle(
                  color: AppColor.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6.0),
              Text(
                'Please enter info to create account',
                style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 46.0),
              AppTextField(
                controller: nameController,
                hintext: 'User Name',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              AppTextField(
                controller: emailController,
                hintext: 'Email Address',
                textInputAction: TextInputAction.next,
              ),
              // const SizedBox(height: 16.0),
              // AppTextField(
              //   controller: phoneController,
              //   hintext: 'Phone',
              //   textInputAction: TextInputAction.next,
              // ),
              const SizedBox(height: 16.0),
              AppTextFieldPassword(
                controller: passwordController,
                hintext: 'Password',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              AppTextFieldPassword(
                controller: confirmPasswordController,
                onChanged: (_) => setState(() {}),
                hintext: 'Confirm Password',
                onFieldSubmitted: (_) => _sendOtp(),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => setState(() => isCheck = !isCheck),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                      child: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        size: 20.0,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to your',
                        style: textStyle.copyWith(color: AppColor.grey),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => log('Pressed privacy policy'),
                            text: ' privacy policy',
                            style: const TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' and'),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => log('Pressed term & conditions'),
                            text: ' term & conditions',
                            style: const TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                height: 70.0,
                child: AppElevatedButton(
                  onPressed: () {
                    _sendOtp();
                  },
                  text: 'Sign up',
                ),
              ),
              const SizedBox(height: 26.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already an account,',
                    style: textStyle.copyWith(color: AppColor.grey),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage())),
                    child: const Text(
                      ' Sign In',
                      style: TextStyle(
                        color: AppColor.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
