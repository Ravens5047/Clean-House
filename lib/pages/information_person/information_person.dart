import 'dart:convert';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/account_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class InformationPerson extends StatefulWidget {
  const InformationPerson({
    Key? key,
    required this.user_id,
  }) : super(key: key);

  final int user_id;

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
  final formKey = GlobalKey<FormState>();
  AccountService accountService = AccountService();
  List<AppUsersModel> detailUsersList = [];
  late int userId;

  @override
  void initState() {
    userId = widget.user_id;
    _getDetailUser(userId);
    super.initState();
  }

  void _getDetailUser(int user_id) async {
    try {
      final response = await accountService.getDetailUser(user_id);
      print('User ID: $user_id');
      print('User ID from SharedPrefs: $user_id');
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          setState(() {
            detailUsersList.add(AppUsersModel.fromJson(responseData));
          });
          print('Call Successful API');
        } else {
          print('No data returned from API');
        }
      } else {
        print('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppUsersModel currentUser =
        detailUsersList.isNotEmpty ? detailUsersList[0] : AppUsersModel();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  color: AppColor.blue,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 38.0),
              AppTextFieldProfile(
                controller: nameController..text = currentUser.username ?? '',
                hintText: "User Name Account",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: first_nameController
                  ..text = currentUser.first_name ?? '',
                hintText: "First Name",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: last_nameController
                  ..text = currentUser.last_name ?? '',
                hintText: "Last Name",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: emailController..text = currentUser.email ?? '',
                hintText: "Email",
                readOnly: true,
                prefixIcon: const Icon(Icons.email, color: AppColor.grey),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: phoneController
                  ..text = currentUser.phone_number ?? '',
                hintText: "Phone",
                prefixIcon: const Icon(Icons.phone, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: addressController
                  ..text = currentUser.address_user ?? '',
                hintText: "Address",
                prefixIcon: const Icon(Icons.home, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 72.0),
              TdElevatedButton(
                // onPressed: _updateProfile,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
