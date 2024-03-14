import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_password.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/auth_services.dart';
import 'package:capstone2_clean_house/utils/validator.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.email});

  final String email;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authServices = APIService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Change Password',
            style: TextStyle(
              color: AppColor.blue,
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
            children: [
              ClipOval(
                child: Image.asset(
                  Assets.images.biaanh1.path,
                  width: 100.0,
                  height: 200.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 46.0),
              AppTextFieldPassword(
                controller: currentPasswordController,
                hintext: 'Current Password',
                validator: Validator.requiredValidator,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldPassword(
                controller: newPasswordController,
                hintext: 'New Password',
                validator: Validator.passwordValidator,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 18.0),
              AppTextFieldPassword(
                controller: confirmPasswordController,
                onChanged: (_) => setState(() {}),
                hintext: 'Confirm Password',
                validator: Validator.confirmPasswordValidator(
                    newPasswordController.text),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 90.0),
              AppElevatedButton.outline(
                text: 'Done',
                isDisable: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
