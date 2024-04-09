import 'dart:async';
import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/pages/onboarding/onboading_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:shimmer/shimmer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    onInit();
  }

  void onInit() async {
    final isLogin = SharedPrefs.isLogin;
    await Future.delayed(const Duration(milliseconds: 5000));
    if (isLogin) {
      Route route = MaterialPageRoute(builder: (context) => const MainPage());
      Navigator.pushAndRemoveUntil(
          context, route, (Route<dynamic> route) => false);
    } else {
      Route route =
          MaterialPageRoute(builder: (context) => const OnboardingPage());
      Navigator.pushAndRemoveUntil(
          context, route, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor.withOpacity(1.0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(
            //   Assets.images.icon_cleanhouse.path,
            //   width: 112.0,
            //   fit: BoxFit.cover,
            // ),
            Lottie.asset('assets/logo_splash_clean.json'),
            Shimmer.fromColors(
              baseColor: Colors.blue,
              highlightColor: Colors.red,
              child: const Text(
                'Clean House Services',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
