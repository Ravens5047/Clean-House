import 'dart:convert';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/model/request/forgot_password_request_model.dart';
import 'package:capstone2_clean_house/pages/auth/forgot_password/otp_screen.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ForgotMail extends StatefulWidget {
  const ForgotMail({super.key});

  @override
  State<ForgotMail> createState() => _ForgotMailState();
}

class _ForgotMailState extends State<ForgotMail> {
  APIService authServices = APIService();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void _send_mail(String otp) async {
    var Service_id = 'service_xx7wprk',
        Template_id = 'template_nclu1k6',
        User_id = 'JM1eP-lgC1smnAyVR';
    await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin': 'http:localhost',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'service_id': Service_id,
        'user_id': User_id,
        'template_id': Template_id,
        'template_params': {
          'name': 'clean_house_services',
          'message': 'You got a new message\nYour OTP is: $otp',
          'sender_email': 'hungnguyenhoang415@gmail.com',
        }
      }),
    );
  }

  Future<void> _submitForgotMail() async {
    if (formKey.currentState!.validate()) {
      final body = ForgotPasswordRequest(
        email: emailController.text.trim(),
        otp: '',
      );
      try {
        final response = await authServices.forgotPassword(body);
        final data = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (data['status'] == 'email_not_found') {
            showTopSnackBar(
              context,
              const Center(
                child: TDSnackBar.error(
                  message: 'Email not found',
                ),
              ),
            );
          } else if (data.containsKey('OTP') && data['OTP'] != null) {
            String otp = data['OTP'];
            _send_mail(otp);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  email: emailController.text.trim(),
                  otp: otp,
                ),
              ),
            );
          } else {
            showTopSnackBar(
              context,
              const Center(
                child: TDSnackBar.error(
                  message: 'OTP not found in response',
                ),
              ),
            );
          }
        } else if (response.statusCode == 500 &&
            data.containsKey('errMessage')) {
          showTopSnackBar(
            context,
            Center(
              child: TDSnackBar.error(
                message: data['errMessage'],
              ),
            ),
          );
        } else {
          showTopSnackBar(
            context,
            TDSnackBar.error(
              message: data['message'] ?? 'An error occurred',
            ),
          );
        }
      } catch (e) {
        showTopSnackBar(
          context,
          TDSnackBar.error(
            message: 'An error occurred: $e',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0)
                    .copyWith(top: MediaQuery.of(context).padding.top + 30.0),
            child: Column(
              children: [
                Text(
                  'Reset Password',
                  style: GoogleFonts.dmSerifText(
                    color: Colors.blue,
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
                  'We will send 4 digits code to your email.',
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
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Return Sign In',
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.7),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                AppElevatedButton(
                  height: 70.0,
                  color: Colors.blue,
                  borderColor: AppColor.grey,
                  splashColor: AppColor.pink,
                  borderRadius: BorderRadius.circular(20.0),
                  onPressed: _submitForgotMail,
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
