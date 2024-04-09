import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/model/onboarding_model.dart';
import 'package:capstone2_clean_house/pages/welcome/welcome_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SharedPrefs.isAccessed = true;
  }

  void _changePage(int pageViewIndex) {
    currentIndex = pageViewIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.blue,
                  highlightColor: Colors.pink,
                  child: const Text(
                    'Clean House Services',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 240.0,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (pageViewIndex) {
                      _changePage(pageViewIndex);
                    },
                    children: List.generate(
                      onboardings.length,
                      (index) => Image.asset(onboardings[index].imagePath ?? '',
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    onboardings[currentIndex].text ?? '',
                    style: const TextStyle(
                        color: AppColor.blue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardings.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: index == currentIndex ? 30.0 : 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 56.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex > 0
                          ? TdElevatedButton.outline(
                              color: AppColor.white,
                              onPressed: () {
                                currentIndex--;
                                pageController.jumpToPage(currentIndex);
                              },
                              text: 'Back',
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                            )
                          : TdElevatedButton.outline(
                              text: 'Back',
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              textColor: AppColor.black.withOpacity(0.6),
                              borderColor: AppColor.grey.withOpacity(0.6),
                            ),
                      TdElevatedButton(
                        onPressed: () {
                          if (currentIndex < onboardings.length - 1) {
                            currentIndex++;
                            pageController.jumpToPage(currentIndex);
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        text: currentIndex == onboardings.length - 1
                            ? 'Start'
                            : 'Next',
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
