import 'dart:convert';
import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar_employee.dart';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/model/request/login_request_model.dart';
import 'package:capstone2_clean_house/model/response/login_response_model.dart';
import 'package:capstone2_clean_house/pages/auth/forgot_password/forgot_mail.dart';
import 'package:capstone2_clean_house/pages/auth/register/register_page.dart';
import 'package:capstone2_clean_house/pages/widget/square_title.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/resources/app_style.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleidController = TextEditingController();
  APIService authServices = APIService();
  final formKey = GlobalKey<FormState>();

  // Future<void> _submitLogin() async {
  //   if (formKey.currentState!.validate()) {
  //     final body = LoginRequestModel(
  //       username: nameController.text.trim(),
  //       password: passwordController.text,
  //       // role: 4,
  //     );
  //     await authServices.login1(body).then((response) async {
  //       if (response.statusCode == 200) {
  //         final loginResponse = Data.fromJson(jsonDecode(response.body));
  //         final token = loginResponse.key;
  //         final user_Id = loginResponse.id;
  //         print('Token: $token');
  //         print('User_id: $user_Id');
  //         if (token != null && user_Id != null) {
  //           await SharedPrefs.setToken(token);
  //           SharedPrefs.setUserId(user_Id);
  //           if (context.mounted) {
  //             Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => const MainPage()),
  //               (Route<dynamic> route) => false,
  //             );
  //           }
  //         } else {
  //           showTopSnackBar(
  //             context,
  //             const TDSnackBar.error(
  //               message: "Invalid token received",
  //             ),
  //           );
  //         }
  //       }
  //     }).catchError((onError) {
  //       showTopSnackBar(
  //         context,
  //         TDSnackBar.error(
  //           message: "Error: $onError",
  //         ),
  //       );
  //     });
  //   }
  // }

  Future<void> _submitLogin() async {
    if (formKey.currentState!.validate()) {
      final body = LoginRequestModel(
        username: nameController.text.trim(),
        password: passwordController.text,
      );
      await authServices.login1(body).then((response) async {
        if (response.statusCode == 200) {
          final loginResponse = Data.fromJson(jsonDecode(response.body));
          final token = loginResponse.key;
          final user_Id = loginResponse.id;
          final role = loginResponse.role;
          print('Token: $token');
          print('User_id: $user_Id');
          print('Role: $role');
          if (token != null && user_Id != null && role != null) {
            await SharedPrefs.setToken(token);
            SharedPrefs.setUserId(user_Id);
            if (context.mounted) {
              if (role == 3) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const MainPageEmployee()),
                  (Route<dynamic> route) => false,
                );
              } else if (role == 4) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                  (Route<dynamic> route) => false,
                );
              } else {
                showTopSnackBar(
                  context,
                  const TDSnackBar.error(
                    message: "Account does not exist",
                  ),
                );
              }
            }
          } else {
            showTopSnackBar(
              context,
              const TDSnackBar.error(
                message: "Invalid token received",
              ),
            );
          }
        }
      }).catchError((onError) {
        showTopSnackBar(
          context,
          TDSnackBar.error(
            message: "Error: $onError",
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              controller: nameController,
              hintext: 'Enter User Name',
              validator: Validator.requiredValidator,
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
                //     builder: (context) => const MainPage(),
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
    );
  }
}
