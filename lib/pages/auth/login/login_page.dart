import 'dart:convert';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/pages/auth/forgot_password/forgot_mail.dart';
import 'package:capstone2_clean_house/pages/auth/register/register_page.dart';
import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/widget/square_title.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/services/remote/body/login_body.dart';
import 'package:capstone2_clean_house/services/remote/code_error.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.email,
  });
  final String? email;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthServices authServices = AuthServices();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? '';
  }

  void _submitLogin() {
    if (formKey.currentState!.validate() == false) {
      return;
    }

    LoginBody body = LoginBody()
      ..email = emailController.text.trim()
      ..password = passwordController.text;

    authServices.login(body).then((response) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success'] == true) {
        String token = data['body']['token'];
        SharedPrefs.token = token;
        print('object token $token');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        print('object message ${data['message']}');
        showTopSnackBar(
          context,
          TDSnackBar.error(
              message: (data['message'] as String?)?.toLang ?? '😐'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              const Center(
                child: Text(
                  'Hello Again!',
                  style: TextStyle(
                      color: AppColor.blue,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 2.0),
              Center(
                child: Text(
                  'Welcome back you have been',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
              ),
              Center(
                child: Text(
                  'missed!',
                  style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                ),
              ),
              const SizedBox(height: 46.0),
              AppTextField(
                controller: emailController,
                hintext: 'Enter Email',
                validator: Validator.emailValidator,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              AppTextFieldPassword(
                controller: passwordController,
                hintext: 'Enter Password',
                validator: Validator.passwordValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ForgotMail(),
                    ),
                  ),
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: AppColor.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 350.0,
                height: 70.0,
                child: AppElevatedButton(
                  // onPressed: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomeScreen(),
                  //   ),
                  // ),
                  onPressed: () {
                    _submitLogin();
                  },
                  text: 'Sign In',
                ),
              ),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColor.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColor.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const SquareTitle(
                      imagePath: 'assets/images/google.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member? ',
                    style: AppStyle.h16Normal.copyWith(color: AppColor.grey),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    ),
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                          color: AppColor.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700),
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
