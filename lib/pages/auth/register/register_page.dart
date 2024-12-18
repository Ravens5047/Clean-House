import 'dart:convert';
import 'dart:developer';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/model/request/register_request_model.dart';
import 'package:capstone2_clean_house/model/response/register_response_model.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late bool isCheck;
  APIService authServices = APIService();
  GlobalKey<FormState> formKey = GlobalKey();
  String errorMessage = '';
  bool isAgreed = false;
  bool isAddressEntered = false;

  @override
  void initState() {
    super.initState();
    isCheck = false;
  }

  Future<void> _submitRegister() async {
    if (!isAgreed) {
      showTopSnackBar(
        context,
        const TDSnackBar.error(
          message: 'Please agree to terms and conditions.',
        ),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      final body = RegisterRequestModel(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        phone_number: phoneController.text.trim(),
        password: passwordController.text,
        role: 4,
        // employee_code: 0,
      );
      await authServices.register(body).then((response) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final data = jsonDecode(response.body);
          final registerResponse = RegisterResponseModel.fromJson(data);
          SharedPrefs.token = registerResponse.data?.token;
          showTopSnackBar(
            context,
            const TDSnackBar.success(
              message: 'Register successfully, login ',
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
          );
        } else {
          final data = jsonDecode(response.body);
          final errorMessage = data['error'];
          showTopSnackBar(
            context,
            TDSnackBar.error(
              message: errorMessage,
            ),
          );
        }
      }).catchError((onError) {
        showTopSnackBar(
          context,
          const TDSnackBar.error(
            message: 'Error signing',
          ),
        );
      });
    }
  }

  void handleTextFieldsChanged(String value) {
    setState(() {
      phoneController.text.length == 10;
    });
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = AppStyle.h16Normal;

    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 64.0, bottom: 72.0),
          children: [
            const Text(
              'Create Your Account',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6.0),
            Shimmer.fromColors(
              baseColor: Colors.blue,
              highlightColor: Colors.orange,
              child: Text(
                'Please enter info to create account',
                style: AppStyle.h18Normal.copyWith(color: AppColor.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 46.0),
            AppTextField(
              controller: nameController,
              hintext: 'User Name',
              validator: Validator.usernameValidator.call,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            AppTextField(
              controller: emailController,
              hintext: 'Email Address',
              validator: Validator.emailValidator.call,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            AppTextField(
              controller: phoneController,
              hintext: 'Phone Number',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onTextChanged: handleTextFieldsChanged,
              validator: phoneNumberValidator,
            ),
            const SizedBox(height: 16.0),
            AppTextFieldPassword(
              controller: passwordController,
              hintext: 'Password',
              validator: Validator.passwordValidator.call,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            AppTextFieldPassword(
              controller: confirmPasswordController,
              onChanged: (_) => setState(() {}),
              hintext: 'Confirm Password',
              onFieldSubmitted: (_) => _submitRegister(),
              validator: Validator.confirmPasswordValidator(
                passwordController.text,
              ).call,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isCheck = !isCheck;
                        isAgreed = isCheck;
                      });
                    }
                  },
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
                            ..onTap = () {
                              if (isCheck) {
                                log('Pressed privacy policy');
                              }
                            },
                          text: ' privacy policy',
                          style: TextStyle(
                            color: isCheck ? Colors.blue : AppColor.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' and'),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (isCheck) {
                                log('Pressed term & conditions');
                              }
                            },
                          text: ' term & conditions',
                          style: TextStyle(
                            color: isCheck ? Colors.blue : AppColor.grey,
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
                color: Colors.blue,
                borderColor: AppColor.grey,
                onPressed: () {
                  _submitRegister();
                },
                text: 'Sign up',
              ),
            ),
            const SizedBox(height: 26.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: textStyle.copyWith(color: AppColor.grey),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage())),
                  child: const Text(
                    ' Sign In',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
