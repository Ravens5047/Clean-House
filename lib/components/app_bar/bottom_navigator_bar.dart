import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int userId;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    try {
      final int? id = SharedPrefs.user_id;
      if (id != null) {
        setState(() {
          userId = id;
        });
      } else {
        print('User id is null');
      }
    } catch (e) {
      print('Error fetching user id: $e');
    }
  }

  List<Widget> _buildPages() {
    return [
      const HomeScreen(),
      Container(
        color: AppColor.blue,
      ),
      Container(
        color: AppColor.blue,
      ),
      InformationPerson(user_id: userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPages()[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
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
