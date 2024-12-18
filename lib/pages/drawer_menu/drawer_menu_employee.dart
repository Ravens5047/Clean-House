import 'dart:convert';
import 'dart:io';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/settings/setting_screen.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';

class DrawerMenuEmployee extends StatefulWidget {
  const DrawerMenuEmployee({
    super.key,
    required this.appUser,
    required this.user_id,
    this.avatarImage,
  });
  final int user_id;
  final AppUsersModel appUser;
  final File? avatarImage;

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
  File? _avatarImage;

  void _updateAvatarImage(File? newAvatarImage) {
    setState(() {
      _avatarImage = newAvatarImage;
    });
  }

  void updateAvatar(File? newAvatarImage) {
    setState(() {
      _avatarImage = newAvatarImage;
    });
  }

  void _checkAvatarImage() async {
    final imagePath = SharedPrefs.getAvatarImagePath(widget.user_id);
    if (imagePath != null) {
      setState(() {
        _avatarImage = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userId = widget.user_id;
    _fetchUserId();
    _initData();
    _checkAvatarImage();
    _updateAvatarImage(_avatarImage);
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
          padding: const EdgeInsets.all(5.0).copyWith(top: 5.0),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                full_name,
                style: GoogleFonts.dmSerifText(
                  fontSize: 17.0,
                  color: AppColor.black,
                ),
              ),
              accountEmail: Text(
                email,
                style: GoogleFonts.nuosuSil(
                  fontSize: 17.0,
                  color: AppColor.black,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: _avatarImage != null
                      ? Image.file(
                          _avatarImage!,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          Assets.images.avatar_default.path,
                          width: 90.0,
                          height: 90.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(
                //     Assets.images.background_clean2.path,
                //   ),
                // ),
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFaffcaf),
                    Color(0xFF12dff3),
                  ],
                ),
                color: AppColor.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                boxShadow: [
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
              color: Colors.blue,
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
                    onTap: () async {
                      final File? newAvatarImage =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(
                            user_id: widget.user_id,
                            avatarImage: widget.avatarImage,
                            updateAvatar: updateAvatar,
                          ),
                        ),
                      );
                      if (newAvatarImage != null) {
                        setState(() {
                          _avatarImage = newAvatarImage;
                        });
                      }
                    },
                    child: const Row(
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Ikonate(
                            Ikonate.settings,
                            color: Colors.blue,
                          ),
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
