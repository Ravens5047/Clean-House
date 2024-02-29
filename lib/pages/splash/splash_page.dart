import 'dart:async';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/pages/welcome/welcome_page.dart';
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

    Timer(const Duration(milliseconds: 2600), () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ));

      Route route =
          MaterialPageRoute(builder: (context) => const WelcomePage());
      Navigator.pushAndRemoveUntil(
          context, route, (Route<dynamic> route) => false);
    });
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
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset(
          //         Assets.images.splash.path,
          //         width: 160.0,
          //       ),
          //       Shimmer.fromColors(
          //         baseColor: AppColor.white,
          //         highlightColor: const Color.fromARGB(255, 250, 226, 6),
          //         child: const Text(
          //           'Foodie Social',
          //           textAlign: TextAlign.center,
          //           style:
          //               TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
