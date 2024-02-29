import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/button/bounder_info.dart';
import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class InformationPerson extends StatefulWidget {
  const InformationPerson({super.key});

  @override
  State<InformationPerson> createState() => _InformationPersonState();
}

class _InformationPersonState extends State<InformationPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Center(
          child: Text(
            'Information Person\t\t\t\t\t',
            style: TextStyle(
              color: AppColor.blue,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BounderInfo(text: 'User Name'),
            const SizedBox(
              height: 50.0,
            ),
            BounderInfo(text: 'Email'),
            const SizedBox(
              height: 50.0,
            ),
            BounderInfo(text: 'Phone'),
            const SizedBox(
              height: 50.0,
            ),
            BounderInfo(text: 'Address'),
            const SizedBox(
              height: 160.0,
            ),
            AppElevatedButton.normal1(text: 'Confirm Change Information'),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Ikonate(
                    Ikonate.home_alt,
                    color: AppColor.blue,
                    height: 40.0,
                  ),
                ),
                const SizedBox(
                  width: 50.0,
                ),
                const Ikonate(
                  Ikonate.calendar_event,
                  color: AppColor.blue,
                  height: 40.0,
                ),
                const SizedBox(
                  width: 50.0,
                ),
                const Ikonate(
                  Ikonate.inbox,
                  color: AppColor.blue,
                  height: 40.0,
                ),
                const SizedBox(
                  width: 50.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const InformationPerson()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Ikonate(
                    Ikonate.user,
                    color: AppColor.blue,
                    height: 40.0,
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
