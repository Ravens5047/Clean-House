import 'dart:convert';
import 'package:capstone2_clean_house/components/app_dialog.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/auth/change_password/change_password_page.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/task_view/task_view_employee.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class DrawerMenuEmployee extends StatefulWidget {
  const DrawerMenuEmployee({
    super.key,
    required this.appUser,
    required this.user_id,
  });
  final int user_id;

  final AppUsersModel appUser;

  @override
  State<DrawerMenuEmployee> createState() => _DrawerMenuEmployeeState();
}

class _DrawerMenuEmployeeState extends State<DrawerMenuEmployee> {
  String username = "";
  String email = "";
  String first_name = "";
  String last_name = "";
  String full_name = "";
  AccountService accountService = AccountService();
  late int userId;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userId = widget.user_id;
    _fetchUserId();
    _initData();
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

  Future<void> _initData() async {
    final currentUser = await _getDetailUser(userId);
    _updateTextControllers(currentUser);
  }

  Future<AppUsersModel> _getDetailUser(int user_id) async {
    final response = await accountService.getDetailUser(user_id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);
      final dynamic userData = responseData['user'][0];
      print('Response data: $responseData');
      if (responseData is Map<String, dynamic>) {
        return AppUsersModel.fromJson(userData);
      } else {
        throw Exception('No data returned from API');
      }
    } else {
      throw Exception('Failed to fetch user details: ${response.statusCode}');
    }
  }

  void _updateTextControllers(AppUsersModel currentUser) {
    print('Current user: $currentUser');
    setState(() {
      print('Updating text controllers with user: ${currentUser.username}');
      username = currentUser.username ?? '';
      email = currentUser.email ?? '';
      first_name = currentUser.first_name ?? '';
      last_name = currentUser.last_name ?? '';
      if (first_name.isEmpty && last_name.isEmpty) {
        full_name = "No Name ??? ";
      } else {
        full_name = '$first_name $last_name';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                full_name,
                style: const TextStyle(
                  fontSize: 17.0,
                  color: AppColor.white,
                ),
              ),
              accountEmail: Text(
                email,
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
                        builder: (context) => const TaskViewEmployee(),
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
                          'Task Employee',
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
                        SharedPrefs.removeSeason();
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
      ),
    );
  }
}
