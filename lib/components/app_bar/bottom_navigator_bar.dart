import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/home_screen/home_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      // NotificationTask(
      //   initialNotifications: widget.initialNotifications ?? [],
      // ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Notifications',
              style: GoogleFonts.dmSerifText(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 1'),
                subtitle:
                    Text('This is a notification from Clean House Services'),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 2'),
                subtitle:
                    Text('This is a notification from Clean House Services'),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 3'),
                subtitle:
                    Text('This is a notification from Clean House Services'),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.notifications_sharp),
                title: Text('Notification 4'),
                subtitle:
                    Text('This is a notification from Clean House Services'),
              ),
            ),
          ],
        ),
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
