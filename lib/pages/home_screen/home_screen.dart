import 'dart:convert';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/drawer_menu/drawer_menu.dart';
import 'package:capstone2_clean_house/pages/services_home/detail_name_services.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  AppUsersModel appUser = AppUsersModel();
  final searchController = TextEditingController();
  bool isDark = false;
  ServicesModel servicesModel = ServicesModel();
  ServicesName servicesName = ServicesName();
  List<ServicesModel> servicesList = [];

  @override
  void initState() {
    _getListServices();
    super.initState();
  }

  void _getListServices() {
    servicesName.getListServices().then((response) {
      if (response.statusCode == 200) {
        List<ServicesModel> tempList = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          ServicesModel service = ServicesModel.fromJson(data);
          tempList.add(service);
        }
        print('Connection Successfully Call API');
        setState(() {
          servicesList = tempList;
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((onError) {
      print('Error occurred: $onError');
    });
  }

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
    print('servicesList length: ${servicesList.length}');
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColor.black,
        foregroundColor: AppColor.black,
        backgroundColor: const Color.fromARGB(255, 163, 216, 247),
      ),
      drawer: DrawerMenu(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Shimmer.fromColors(
                      baseColor: Colors.blue,
                      highlightColor: AppColor.pink,
                      child: Text(
                        'Provide You \nBetter Clean \nHouse',
                        style: GoogleFonts.oldenburg(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.asset(
                      //   Assets.images.biaanh2.path,
                      //   width: 250.0,
                      // ),
                      Lottie.asset(
                        'assets/clean1.json',
                        width: 250.0,
                      ),
                      Text(
                        'What \nService \nDo You \nNeed ?',
                        style: GoogleFonts.dmSerifText(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Our Services',
                      style: GoogleFonts.dmSerifText(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 240.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: servicesList.length,
                      itemBuilder: (context, index) {
                        final service = servicesList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailNameServices(
                                        service: service,
                                      ),
                                    ),
                                  );
                                },
                                // child: Image.asset(
                                //   Assets.images.biaanh2.path,
                                //   width: 120.0,
                                //   fit: BoxFit.cover,
                                // ),
                                child: service.image != null
                                    ? Image.network(
                                        '${AppConstant.baseAPIimages}${service.image}',
                                        width: 205.0,
                                        height: 205.0,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        Assets.images.services1.path,
                                        width: 205.0,
                                        height: 205.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                service.name_service ?? 'Unknown service',
                                style: const TextStyle(
                                  color: AppColor.blue,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
