import 'dart:convert';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/settings/setting_screen.dart';
import 'package:capstone2_clean_house/pages/task_view_employee/task_view_employee.dart';
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
                  color: AppColor.black,
                ),
              ),
              accountEmail: Text(
                email,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: AppColor.black,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    Assets.images.avatar_default.path,
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.background_clean2.path,
                  ),
                ),
                color: AppColor.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.grey,
                    blurRadius: 10.0,
                    spreadRadius: BorderSide.strokeAlignInside,
                    offset: Offset(10, 15),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(8.0),
              currentAccountPictureSize: const Size.square(70),
            ),
            const Divider(
              height: 10.0,
              thickness: 2.0,
              color: AppColor.blue,
              endIndent: 10.0,
              indent: 10.0,
            ),
            const SizedBox(
              height: 10.0,
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
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => SettingScreen(
                              user_id: widget.user_id,
                            ),
                          ),
                        )
                        .then(
                          (_) => _initData(),
                        ),
                    child: const Row(
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Ikonate(Ikonate.settings),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
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
