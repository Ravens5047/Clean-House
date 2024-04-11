import 'dart:async';
import 'dart:convert';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/model/request/change_password_request_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authServices = APIService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int wrongPasswordCount = 0;

  Future<void> _changePassword() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final oldPassword = oldPasswordController.text;
      final newPassword = newPasswordController.text;
      final user_id = SharedPrefs.user_id;
      if (user_id != null) {
        final request = ChangePasswordRequest(
          user_id: user_id,
          oldPassword: oldPassword,
          newPassword: newPassword,
        );
        try {
          final response = await authServices.changePassword(user_id, request);
          final responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            final message =
                responseData['message'] ?? responseData['errMessage'];
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message ?? 'Password changed successfully'),
                backgroundColor: Colors.green,
              ),
            );
            setState(() {
              isLoading = false;
            });
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            wrongPasswordCount = 0;
          } else if (response.statusCode == 404) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User not found'),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              isLoading = false;
              wrongPasswordCount = 0;
            });
          } else {
            final errorMessage = responseData['message'];
            wrongPasswordCount++;
            String message;
            if (wrongPasswordCount < 3) {
              message =
                  'Password is wrong, please try again. You have entered wrong password $wrongPasswordCount time(s).';
            } else {
              message =
                  'You have entered wrong password 3 times. Returning to home page.';
              Navigator.of(context).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage ?? message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              isLoading = false;
            });
            Timer(const Duration(seconds: 2), () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            });
          }
        } catch (e) {
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again later.'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isLoading = false;
          });
          Timer(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          isLoading = false;
        });
        Timer(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Change Password',
            style: GoogleFonts.dmSerifText(
              color: AppColor.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              ClipOval(
                child: Image.asset(
                  Assets.images.biaanh1.path,
                  width: 100.0,
                  height: 200.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 46.0),
              AppTextFieldPassword(
                controller: oldPasswordController,
                hintext: 'Current Password',
                validator: Validator.requiredValidator.call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldPassword(
                controller: newPasswordController,
                hintext: 'New Password',
                validator: Validator.passwordValidator.call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldPassword(
                controller: confirmPasswordController,
                onChanged: (_) => setState(() {}),
                hintext: 'Confirm Password',
                validator: Validator.confirmPasswordValidator(
                        newPasswordController.text)
                    .call,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 90.0),
              AppElevatedButton.outline(
                text: 'Done',
                isDisable: isLoading,
                onPressed: _changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
