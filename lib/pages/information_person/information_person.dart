import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class InformationPerson extends StatefulWidget {
  const InformationPerson({
    super.key,
    required this.appUser,
  });

  final AppUserModel appUser;

  @override
  State<InformationPerson> createState() => _InformationPersonState();
}

class AppUserModel {}

class _InformationPersonState extends State<InformationPerson> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _updateProfile() async {}
  // @override
  // void initState() {
  //   super.initState();
  //   nameController.text = widget.appUser.username ?? '';
  //   emailController.text = widget.appUser.email ?? '';
  //   // setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
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
              // Center(
              //   child: _buildAvatar(),
              // ),
              const SizedBox(height: 42.0),
              AppTextFieldProfile(
                controller: nameController,
                hintext: "Full Name",
                prefixIcon: const Icon(Icons.person, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: emailController,
                hintext: "Email",
                readOnly: true,
                prefixIcon: const Icon(Icons.email, color: AppColor.grey),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: phoneController,
                hintext: "Phone",
                prefixIcon: const Icon(Icons.phone, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldProfile(
                controller: addressController,
                hintext: "Address",
                prefixIcon: const Icon(Icons.home, color: AppColor.grey),
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 72.0),
              TdElevatedButton(
                onPressed: _updateProfile,
                text: 'Save',
                isDisable: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
