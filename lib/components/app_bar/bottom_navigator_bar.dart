import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  List<Widget> pages = [
    const HomeScreen(),
    Container(
      color: AppColor.blue,
    ),
    Container(
      color: AppColor.blue,
    ),
    InformationPerson(
      appUser: AppUserModel(),
    ),
  ];

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Ikonate(
              Ikonate.home_alt,
              color: AppColor.blue,
              height: 40.0,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Ikonate(
              Ikonate.calendar_event,
              color: AppColor.blue,
              height: 40.0,
            ),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Ikonate(
              Ikonate.box,
              color: AppColor.blue,
              height: 40.0,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Ikonate(
              Ikonate.user,
              color: AppColor.blue,
              height: 40.0,
            ),
            label: 'Informations',
          ),
        ],
      ),
    );
  }
}
