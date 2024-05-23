import 'dart:convert';
import 'dart:io';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/auth/login/login_page.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchAccountScreen extends StatefulWidget {
  const SwitchAccountScreen({
    super.key,
    required this.appUser,
    this.user_id,
    this.avatarImage,
  });

  final AppUsersModel appUser;
  final int? user_id;
  final File? avatarImage;

  @override
  State<SwitchAccountScreen> createState() => _SwitchAccountScreenState();
}

class _SwitchAccountScreenState extends State<SwitchAccountScreen> {
  String username = "";
  String email = "";
  String first_name = "";
  String last_name = "";
  String full_name = "";
  AccountService accountService = AccountService();
  late int userId;
  final formKey = GlobalKey<FormState>();
  File? _avatarImage;
  final bool isLogin = SharedPrefs.isLogin;
  late List<AppUsersModel> accounts;
  late int currentUserId;

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
    final imagePath = SharedPrefs.getAvatarImagePath(widget.user_id ?? 0);
    if (imagePath != null) {
      setState(() {
        _avatarImage = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userId = widget.user_id ?? 0;
    _fetchUserId();
    _initData();
    _checkAvatarImage();
    _updateAvatarImage(_avatarImage);
    accounts = [widget.appUser];
    currentUserId = widget.user_id ?? 0;
    _fetchAccounts();
  }

  void _fetchAccounts() async {
    final List<int>? userIds = await SharedPrefs.getSavedUserIds();
    if (userIds != null) {
      for (int userId in userIds) {
        if (userId != currentUserId) {
          final user = await SharedPrefs.getSavedUser(userId);
          if (user != null) {
            setState(() {
              accounts.add(user);
            });
          }
        }
      }
    }
  }

  void _addNewAccount() async {
    final newUser = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
    if (newUser != null && newUser is AppUsersModel) {
      setState(() {
        accounts.add(newUser);
      });
      await SharedPrefs.saveUser(newUser);
      _switchAccount(newUser.user_id ?? 0);
    }
  }

  void _switchAccount(int userId) {
    setState(() {
      currentUserId = userId;
    });
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

  void _removeAccount(int userId) async {
    await SharedPrefs.removeUser(userId);
    setState(() {
      accounts.removeWhere((user) => user.user_id == userId);
    });
  }

  void _showConfirmationDialog(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Confirmation")),
          content: const Text(
            "Are you sure you want to remove this account?",
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    _removeAccount(userId);
                    Navigator.of(context).pop();
                    _showSnackBar(context, "Account removed successfully");
                  },
                  child: const Text("Remove"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Switch Account',
          style: GoogleFonts.dmSerifText(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFFaffcaf),
                  Color(0xFF12dff3),
                ],
              ),
              color: Colors.grey.withOpacity(0.4),
            ),
            child: const Center(
              child: Text(
                'Add an account for quick login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListView.builder(
                itemCount: accounts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: _addNewAccount,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                child: Image.asset(
                                  Assets.images.addAccouunt.path,
                                  color: AppColor.black,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              const Text(
                                'Add Account',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Divider(
                          thickness: 2.0,
                          endIndent: 30.0,
                          indent: 30.0,
                          color: AppColor.blue,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  }
                  final user = accounts[index - 1];
                  return GestureDetector(
                    onTap: () => _switchAccount(user.user_id ?? 0),
                    child: Row(
                      children: [
                        ClipOval(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: _avatarImage != null
                              ? Image.file(
                                  _avatarImage!,
                                  width: 70.0,
                                  height: 70.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  Assets.images.avatar_default.path,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                full_name,
                                style: GoogleFonts.almendra(
                                  fontSize: 15.0,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                email,
                                style: GoogleFonts.notoSansOlChiki(
                                  fontSize: 11.0,
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          SharedPrefs.isLogin ? 'Logged' : 'Logged out',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _showConfirmationDialog(
                              context, user.user_id ?? 0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
