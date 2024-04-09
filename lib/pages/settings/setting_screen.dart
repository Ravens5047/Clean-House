import 'dart:convert';
import 'package:capstone2_clean_house/components/app_dialog.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/auth/change_password/change_password_page.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/pages/comming_soon/comming_soon_screen.dart';
import 'package:capstone2_clean_house/pages/information_person/information_person.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.user_id,
  });

  final int user_id;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String username = "";
  String email = "";
  String first_name = "";
  String last_name = "";
  String full_name = "";
  AccountService accountService = AccountService();
  late int userId;
  final formKey = GlobalKey<FormState>();
  AppUsersModel appUser = AppUsersModel();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting Screen',
          style: GoogleFonts.notoSansPalmyrene(
            fontSize: 24.0,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.background_clean2.path),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        Assets.images.avatar_default.path,
                        width: 90.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          full_name,
                          style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            color: AppColor.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => InformationPerson(
                            user_id: userId,
                            appUser: appUser,
                          ),
                        ),
                      )
                          .then((_) {
                        _initData();
                      }),
                      child: const Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Text('Edit Information Person'),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage(),
                        ),
                      ),
                      child: const Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Text('Change Password'),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CommingSoonScreen(),
                            ),
                          );
                        },
                        title: const Text('Terms & Conditions'),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Card(
                      child: ListTile(
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
                        title: const Text('Sign Out'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CommingSoonScreen(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Divider(
                              indent: 30.0,
                              endIndent: 30.0,
                              thickness: 2.0,
                              color: AppColor.blue,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Help Center',
                              style: GoogleFonts.alatsi(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Privacy Policy',
                              style: GoogleFonts.alatsi(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.blue,
                              highlightColor: AppColor.pink,
                              child: Text(
                                'About Clean House Services',
                                style: GoogleFonts.alatsi(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.blue),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Shimmer.fromColors(
                              baseColor: AppColor.black,
                              highlightColor: AppColor.blue,
                              child: Text(
                                'Version: 1.0.0',
                                style: GoogleFonts.alatsi(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
