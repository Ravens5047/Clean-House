import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/pages/notifications/notifications_task.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.initialNotifications = const [],
  });

  final List<Map<String, String>>? initialNotifications;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppUsersModel appUser = AppUsersModel();
  late int userId;
  int currentPageIndex = 0;
  List<bool> isSelected = [true, false, false, false];

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
      NotificationTask(
        initialNotifications: widget.initialNotifications ?? [],
      ),
      InformationPerson(
        user_id: userId,
        appUser: appUser,
      ),
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
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = (i == index);
            }
          });
        },
        backgroundColor: AppColor.white,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Ikonate(
              Ikonate.home_alt,
              color: isSelected[0] ? Colors.blue : Colors.black,
              height: 40.0,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Ikonate(
              Ikonate.bell,
              color: isSelected[1] ? Colors.blue : Colors.black,
              height: 40.0,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Ikonate(
              Ikonate.user,
              color: isSelected[2] ? Colors.blue : Colors.black,
              height: 40.0,
            ),
            label: 'Informations',
          ),
        ],
      ),
    );
  }
}
