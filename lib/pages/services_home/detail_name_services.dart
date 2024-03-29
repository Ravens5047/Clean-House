import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/gen/assets_gen.dart';
import 'package:capstone2_clean_house/model/services_model.dart';
import 'package:capstone2_clean_house/pages/services_home/services_name_cleaning.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

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
            style: const TextStyle(
              color: AppColor.blue,
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  child: Image.asset(
                    Assets.images.services1.path,
                    width: 300,
                    height: 300,
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
                      fontSize: 20.0,
                      color: AppColor.blue,
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
                  height: 30.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Unit Price Service',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColor.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
                    '${widget.service.unit_price.toString()} \$',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                AppElevatedButton.normal1(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ServicesNameCleaning(
                          service: widget.service,
                        ),
                      ),
                    );
                  },
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
