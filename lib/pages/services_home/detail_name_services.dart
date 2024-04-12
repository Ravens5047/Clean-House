import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/booking_services/booking_services_Place.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DetailNameServices extends StatefulWidget {
  const DetailNameServices({
    super.key,
    required this.service,
  });

  final ServicesModel service;

  @override
  State<DetailNameServices> createState() => _DetailNameServicesState();
}

class _DetailNameServicesState extends State<DetailNameServices> {
  final formKey = GlobalKey<FormState>();
  ServicesModel servicesModel = ServicesModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            widget.service.name_service ?? '-:-',
            style: GoogleFonts.mandali(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    child: Image.network(
                      '${AppConstant.baseAPIimages}${widget.service.image}',
                      width: 300.0,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descriptions Service',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.black.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(17.0),
                    child: Text(
                      widget.service.description ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Lottie.asset(
                    'assets/Trainning2.json',
                    width: 500.0,
                    height: 200.0,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  AppElevatedButton.normal1(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingServicesPlace(
                            name_service: widget.service.name_service ?? '',
                          ),
                        ),
                      );
                    },
                    text: 'Continue',
                    color: Colors.blue,
                    borderColor: AppColor.grey,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
