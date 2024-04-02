import 'package:capstone2_clean_house/components/button/selection_house_type.dart';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/model/google_map_model.dart';
import 'package:capstone2_clean_house/pages/services_home/booking_services/booking_services_time_selection.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingServicesPlace extends StatefulWidget {
  const BookingServicesPlace({super.key});

  @override
  State<BookingServicesPlace> createState() => _BookingServicesPlaceState();
}

class _BookingServicesPlaceState extends State<BookingServicesPlace> {
  TextEditingController typeHouseController = TextEditingController();
  String? selectedLocation;
  List<bool> isSelected = [false, false, false];
  int? selectedHouse;
  GoogleMapModel selectedShop = GoogleMapModel();
  bool isAddressEntered = false;

  void handleFrequencySelection(int index) {
    setState(() {
      if (selectedHouse == index) {
        selectedHouse = null;
      } else {
        selectedHouse = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Selection type house, number house',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Selection type house',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                handleFrequencySelection(0);
              },
              child: SelectionHouse(
                text: 'House',
                isSelected: selectedHouse == 0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                handleFrequencySelection(1);
              },
              child: SelectionHouse(
                text: 'Apartment',
                isSelected: selectedHouse == 1,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                handleFrequencySelection(2);
              },
              child: SelectionHouse(
                text: 'Villas',
                isSelected: selectedHouse == 2,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Selection number house',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            AppTextFieldProfile(
              controller: typeHouseController,
              hintText: 'Add Address to House',
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                setState(() {
                  isAddressEntered = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '*Please selection type house, number house appropriately, Tasker easy searching for house.',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TimeSelection(),
                  ),
                );
              },
              child: TdElevatedButton.fullmau(
                text: 'Continue',
                color: isAddressEntered ? AppColor.green : AppColor.orange,
                borderColor:
                    isAddressEntered ? AppColor.green : AppColor.orange,
                // onPressed: isAddressEntered
                //     ? () {
                //         Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => const TimeSelection(),
                //           ),
                //         );
                //       }
                //     : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
