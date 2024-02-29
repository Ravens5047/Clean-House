import 'dart:developer';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  TextEditingController phoneController = TextEditingController();
  late bool isCheck;
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool validatedAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    isCheck = false;
  }

  Future<void> registerUser() async {
    const String apiUrl = "http://localhost:3000/users";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'confirmpassword': confirmPasswordController.text,
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng ký thất bại, vui lòng thử lại!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = AppStyle.h16Normal;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
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
            const SizedBox(height: 16.0),
            AppTextField(
              controller: phoneController,
              hintext: 'Phone',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
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
            const SizedBox(height: 40.0),
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
                onPressed: () async {
                  try {
                    await registerUser();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                          child: Text(
                            'User registered successfully',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        backgroundColor: AppColor.blue,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                          child: Text(
                            'Failed to register user. Please try again.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        backgroundColor: AppColor.blue,
                      ),
                    );
                  }
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
    );
  }
}
