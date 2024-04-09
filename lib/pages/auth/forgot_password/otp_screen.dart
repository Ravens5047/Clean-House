// ignore_for_file: no_logic_in_create_state

import 'dart:convert';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/model/request/forgot_password_request_model.dart';
import 'package:capstone2_clean_house/pages/auth/forgot_password/forgot_create_password.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String? otp;
  @override
  State<OTPScreen> createState() => _OTPScreenState(email: email, otp: otp);
}

class _OTPScreenState extends State<OTPScreen> {
  APIService authServices = APIService();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final OTPController = TextEditingController();
  String receivedOTP = '';
  final String email;
  final String? otp;
  _OTPScreenState({
    required this.email,
    required this.otp,
  });
  @override
  void initState() {
    super.initState();
    print(widget.email);
  }

  void _send_mail(String otp) async {
    var Service_id = 'service_ud386dh',
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

  Future<void> _submitResendOTP() async {
    if (formKey.currentState!.validate()) {
      final body = ForgotPasswordRequest(
        email: emailController.text.trim(),
        otp: '',
      );
      await authServices.forgotPassword(body).then((response) {
        final data = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          String otp = data['OTP'];
          _send_mail(otp);
          setState(() {
            receivedOTP = otp;
          });
        } else {
          showTopSnackBar(
            context,
            TDSnackBar.error(
              message: data['message'],
            ),
          );
        }
      });
    }
  }

  Future<void> _submitVerifyOTP() async {
    if (formKey.currentState!.validate()) {
      String enteredOTP = OTPController.text.trim();
      if (enteredOTP == receivedOTP) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreatePasswordScreen(
              email: email,
              otp: otp,
            ),
          ),
        );
      } else {
        showTopSnackBar(
          context,
          const TDSnackBar.error(
            message: "Invalid OTP. Please try again.",
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PinTheme defaultTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: const TextStyle(
        fontSize: 25,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          color: AppColor.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    PinTheme focusedTheme = PinTheme(
      height: 75,
      width: 75,
      textStyle: const TextStyle(
        fontSize: 25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.orange,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "OTP Verification",
                    style: GoogleFonts.dmSerifText(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  "Enter the verification code we just sent on your email address.",
                  style: TextStyle(
                    color: Color(0xFF8391A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                children: [
                  Expanded(
                    child: Pinput(
                      defaultPinTheme: defaultTheme,
                      focusedPinTheme: focusedTheme,
                      submittedPinTheme: focusedTheme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: AppColor.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: _submitVerifyOTP,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't received code? ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: _submitResendOTP,
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
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
