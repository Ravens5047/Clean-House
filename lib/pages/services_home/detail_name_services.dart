import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/constants/app_constant.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/booking_services/booking_services_Place.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            widget.service.service_name ?? '-:-',
            style: GoogleFonts.mandali(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Image.network(
                        '${AppConstant.baseAPIimages}${widget.service.image}',
                        width: 320.0,
                        height: 320.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Unit Price Services',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Price: 105,600 VND',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '~',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '900,000 VND',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Spacer(),
              AppElevatedButton.normal1(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookingServicesPlace(
                        service_name: widget.service.service_name ?? '',
                        service_id: widget.service.service_id ?? 0,
                      ),
                    ),
                  );
                },
                text: 'Continue',
                color: Colors.blue,
                borderColor: AppColor.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
