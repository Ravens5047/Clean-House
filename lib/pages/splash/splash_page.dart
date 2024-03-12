import 'dart:async';
import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/pages/welcome/welcome_page.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
// import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    await Future.delayed(const Duration(milliseconds: 2000));
    if (isLogin) {
      Route route = MaterialPageRoute(builder: (context) => const MainPage());
      Navigator.pushAndRemoveUntil(
          context, route, (Route<dynamic> route) => false);
    } else {
      Route route =
          MaterialPageRoute(builder: (context) => const WelcomePage());
      Navigator.pushAndRemoveUntil(
          context, route, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.images.splash.path,
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
