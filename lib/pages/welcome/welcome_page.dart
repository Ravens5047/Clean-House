import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/auth/register/register_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final textStyle = AppStyle.h14Medium.copyWith(color: AppColor.brown);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Lottie.asset(
              'assets/house_cloud.json',
              width: size.width,
            ),
          ),
          Positioned(
            left: 20.0,
            top: 510.0,
            right: 20.0,
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.blue,
                highlightColor: Colors.red,
                child: const Text(
                  'Clean House Services',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 48, 7, 233),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            top: 560.0,
            right: 50.0,
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.blue,
                highlightColor: Colors.orange,
                child: const Text(
                  'Hello Everyone, Welcome to our',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 58, 56, 56),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            top: 580.0,
            right: 50.0,
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.blue,
                highlightColor: Colors.orange,
                child: const Text(
                  'application',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 58, 56, 56),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            right: 10.0,
            bottom: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 170.0,
                  height: 70.0,
                  child: AppElevatedButton(
                    splashColor: AppColor.red,
                    highlightColor: AppColor.blue,
                    borderColor: AppColor.grey,
                    borderRadius: BorderRadius.circular(20.0),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    text: 'Sign In',
                  ),
                ),
                SizedBox(
                  width: 170.0,
                  height: 70.0,
                  child: AppElevatedButton.outline(
                    splashColor: AppColor.red,
                    highlightColor: AppColor.blue,
                    borderColor: AppColor.grey,
                    borderRadius: BorderRadius.circular(20.0),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                        (route) => false),
                    text: 'Register',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
