import 'dart:convert';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPerson extends StatefulWidget {
  const InformationPerson({
    super.key,
    required this.user_id,
    required this.appUser,
  });

  final int user_id;
  final AppUsersModel appUser;

  @override
  State<InformationPerson> createState() => _InformationPersonState();
}

class _InformationPersonState extends State<InformationPerson> {
  final nameController = TextEditingController();
  final first_nameController = TextEditingController();
  final last_nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final fullnameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AccountService accountService = AccountService();
  List<AppUsersModel> detailUsersList = [];
  late int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.user_id;
    _initData();
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
      nameController.text = currentUser.username ?? '';
      emailController.text = currentUser.email ?? '';
      first_nameController.text = currentUser.first_name ?? '';
      last_nameController.text = currentUser.last_name ?? '';
      phoneController.text = currentUser.phone_number ?? '';
      addressController.text = currentUser.address_user ?? '';
      SharedPrefs.setPhoneNumber(currentUser.phone_number ?? '');
      SharedPrefs.setAdress_User(currentUser.address_user ?? '');
    });
  }

  void _updateProfile() async {
    if (formKey.currentState!.validate()) {
      final updatedUser = AppUsersModel(
        user_id: userId,
        username: nameController.text.trim(),
        email: emailController.text.trim(),
        first_name: first_nameController.text.trim(),
        last_name: last_nameController.text.trim(),
        phone_number: phoneController.text.trim(),
        address_user: addressController.text.trim(),
      );
      try {
        final response =
            await accountService.UpdateDetailUser(userId, updatedUser.toJson());
        if (response.statusCode == 200 || response.statusCode == 201) {
          _updateTextControllers(updatedUser);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Profile updated successfully.')),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                  child:
                      Text('Failed to update profile: ${response.statusCode}')),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('Failed to update profile: $e')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 36.0, bottom: 10.0),
            children: [
              Text(
                'My Profile',
                style: GoogleFonts.dmSerifText(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 38.0),
              AppTextFieldProfile(
                controller: nameController,
                hintText: "User Name Account",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                readOnly: true,
                // validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: first_nameController,
                hintText: "First Name",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                // validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: last_nameController,
                hintText: "Last Name",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                // validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: emailController,
                hintText: "Email",
                readOnly: true,
                prefixIcon: const Icon(Icons.email, color: AppColor.grey),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: phoneController,
                hintText: "Phone",
                prefixIcon: const Icon(Icons.phone, color: AppColor.grey),
                // validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: addressController,
                hintText: "Address",
                prefixIcon: const Icon(Icons.home, color: AppColor.grey),
                // validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 72.0),
              TdElevatedButton(
                borderColor: AppColor.grey,
                onPressed: _updateProfile,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
