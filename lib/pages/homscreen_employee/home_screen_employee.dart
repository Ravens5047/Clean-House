import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/drawer_menu/drawer_menu_employee.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({super.key});

  @override
  State<HomeScreenEmployee> createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
  AppUsersModel appUser = AppUsersModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Home Screen',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 74, 180, 241),
      ),
      drawer: DrawerMenuEmployee(
        appUser: appUser,
        user_id: appUser.user_id ?? 0,
      ),
      body: Form(
        key: formKey,
        child: ListView(),
      ),
    );
  }
}
