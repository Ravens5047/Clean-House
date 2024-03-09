import 'package:capstone2_clean_house/components/app_dialog.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/auth/change_password/change_password_page.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/history_order/history_order.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    super.key,
    required this.appUser,
  });

  final AppUsersModel appUser;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.appUser.username ?? '-:-',
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColor.white,
              ),
            ),
            accountEmail: Text(
              widget.appUser.email ?? '-:-',
              style: const TextStyle(
                fontSize: 15.0,
                color: AppColor.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  Assets.images.biaanh1.path,
                  width: 90.0,
                  height: 90.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.images.backgroundProfile.path,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HistoryOrder(),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Ikonate(Ikonate.history),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(
                        email: '',
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Ikonate(Ikonate.lock),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 450.0,
                ),
                InkWell(
                  onTap: () => AppDialog.dialog(
                    context,
                    title: 'Sign Out',
                    content: 'Do you want to logout ?',
                    action: () async {
                      await SharedPrefs.removeSeason;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Row(
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Ikonate(
                          Ikonate.exit,
                          color: AppColor.blue,
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColor.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
