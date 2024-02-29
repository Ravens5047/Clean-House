import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/auth/register/register_page.dart';
import 'package:flutter/material.dart';

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
            child: Image.asset(Assets.images.biaanh1.path, width: size.width),
          ),
          const Positioned(
            left: 20.0,
            top: 510.0,
            right: 20.0,
            child: Column(
              children: [
                Text(
                  'Clean House Services',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 48, 7, 233),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 60.0,
            top: 560.0,
            right: 50.0,
            child: Center(
              child: Text(
                'Hello Everyone, Welcome to our',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 58, 56, 56),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 60.0,
            top: 580.0,
            right: 50.0,
            child: Center(
              child: Text(
                'application',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 58, 56, 56),
                  fontWeight: FontWeight.w300,
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
