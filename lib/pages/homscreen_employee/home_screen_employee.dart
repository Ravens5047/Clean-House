import 'dart:convert';

import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/drawer_menu/drawer_menu_employee.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenEmployee extends StatefulWidget {
  const HomeScreenEmployee({super.key});

  @override
  State<HomeScreenEmployee> createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
  final searchController = TextEditingController();
  AppUsersModel appUser = AppUsersModel();
  final formKey = GlobalKey<FormState>();
  ServicesName servicesName = ServicesName();
  List<ServicesModel> servicesList = [];

  void _searchServices(String name_service) {
    servicesName.searchServices(name_service).then((response) {
      if (response.statusCode == 200) {
        List<ServicesModel> tempList = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          ServicesModel service = ServicesModel.fromJson(data);
          tempList.add(service);
        }
        setState(() {
          servicesList = tempList;
        });
      } else {
        print('Failed to search services');
      }
    }).catchError((onError) {
      print('Error occurred: $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee Home Screen',
          style: GoogleFonts.alfaSlabOne(
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search services...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      _searchServices(value);
                    },
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
