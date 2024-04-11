import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/model/request/change_password_otp_request_model.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String? otp;

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authServices = APIService();
  final formKey = GlobalKey<FormState>();
  late String otp;

  @override
  void initState() {
    super.initState();
    otp = widget.otp ?? '';
    print(widget.email);
    print(widget.otp);
  }

  void _submitResetPassword() async {
    if (formKey.currentState!.validate()) {
      final body = ChangePasswordOtpRequest(
        email: widget.email,
        otp: otp,
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      await authServices.changePasswordOTP(body).then((response) {
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          showTopSnackBar(
            context,
            const TDSnackBar.error(
              message: "New password and confirmation password do not match.",
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "Create new password",
                    style: GoogleFonts.dmSerifText(
                      fontSize: 35.0,
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
                  "Your new password must be unique from those previously used.",
                  style: TextStyle(
                    color: Color(0xFF8391A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //password
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AppTextFieldPassword(
                      controller: newPasswordController,
                      hintext: 'New Password',
                      validator: Validator.requiredValidator.call,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20.0),
                    AppTextFieldPassword(
                      controller: confirmPasswordController,
                      hintext: 'Confirm Password',
                      validator: Validator.requiredValidator.call,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                        onPressed: _submitResetPassword,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Reset Password",
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
