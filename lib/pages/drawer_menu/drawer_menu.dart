import 'package:capstone2_clean_house/components/app_text_field.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/pages/auth/change_password/change_password_page.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/history_order/history_order.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Hwgn',
              style: TextStyle(
                fontSize: 20.0,
                color: AppColor.white,
              ),
            ),
            accountEmail: const Text(
              'hungnguyenhoang415@gmail.com',
              style: TextStyle(
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/amazing-beautiful-sky-with-clouds_58702-1653.jpg?w=1380&t=st=1708876219~exp=1708876819~hmac=d7c0f644226f22adfa8b6e220f1df2fed2cc2edb037afd39170d935f1f01e449',
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
                          fontWeight: FontWeight.w500,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 520.0,
                ),
                InkWell(
                  onTap: () => AppDialog.dialog(
                    context,
                    title: 'Sign Out',
                    content: 'Do you want to logout ?',
                    action: () async {
                      await SharedPrefs.removeSeason();
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
