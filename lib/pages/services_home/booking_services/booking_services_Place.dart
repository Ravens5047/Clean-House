import 'package:capstone2_clean_house/components/button/selection_house_type.dart';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/components/text_field/note_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/selection_time_sized.dart';
import 'package:capstone2_clean_house/model/google_map_model.dart';
import 'package:capstone2_clean_house/pages/services_home/booking_services/booking_services_selection_time_working.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';

class BookingServicesPlace extends StatefulWidget {
  const BookingServicesPlace({super.key});

  @override
  State<BookingServicesPlace> createState() => _BookingServicesPlaceState();
}

class _BookingServicesPlaceState extends State<BookingServicesPlace> {
  TextEditingController typeHouseController = TextEditingController();
  TextEditingController typeNumberController = TextEditingController();
  String? selectedLocation;
  List<bool> isSelected = [false, false, false];
  int? selectedHouse;
  int? selectTime;
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

  void handleFrequencySelectionTime(int index) {
    setState(() {
      if (selectTime == index) {
        selectTime = null;
      } else {
        selectTime = index;
      }
    });
  }

  void handleTextFieldsChanged(String value) {
    setState(() {
      isAddressEntered = typeHouseController.text.isNotEmpty &&
          typeNumberController.text.isNotEmpty;
    });
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address';
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selection Work Locations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Information Address and Number Phone',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              AppTextFieldProfile(
                controller: typeHouseController,
                hintText: 'Address to House',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  setState(() {
                    isAddressEntered = value.isNotEmpty;
                  });
                },
                onTextChanged: handleTextFieldsChanged,
                validator: addressValidator,
              ),
              const SizedBox(
                height: 10.0,
              ),
              AppTextFieldProfile(
                controller: typeNumberController,
                hintText: 'Phone Number',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  setState(() {
                    isAddressEntered = value.isNotEmpty;
                  });
                },
                onTextChanged: handleTextFieldsChanged,
                validator: phoneNumberValidator,
              ),
              const SizedBox(
                height: 10.0,
              ),
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
                  text: 'House / Town House',
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
              const Divider(
                thickness: 2.0,
                height: 40.0,
                color: AppColor.blue,
              ),
              const Text(
                'Area',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Please provide an accurate estimate of the area requirement cleanup',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {
                  handleFrequencySelectionTime(0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectionTime(
                    text: 'Max 80m² \n\nMax 2 people / 4 hours',
                    isSelected: selectTime == 0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  handleFrequencySelectionTime(1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectionTime(
                    text: 'Max 80m² \n\nMax 2 people / 4 hours',
                    isSelected: selectTime == 1,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  handleFrequencySelectionTime(2);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectionTime(
                    text: 'Max 80m² \n\nMax 2 people / 4 hours',
                    isSelected: selectTime == 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              NoteTextField(
                text:
                    '! You should choose the number of Taskers first. Working time will depend on actual workload. Before starting work, you can discuss with the tasker and adjust the time accordingly.',
              ),
              const SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  if (isAddressEntered &&
                      typeNumberController.text.isNotEmpty &&
                      addressValidator(typeHouseController.text) == null &&
                      phoneNumberValidator(typeNumberController.text) == null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const BookingServicesSelectionTimeWorking(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                            child:
                                Text('Please enter address and phone number')),
                      ),
                    );
                  }
                },
                child: TdElevatedButton.fullmau(
                  text: 'Continue',
                  color: isAddressEntered ? AppColor.blue : AppColor.grey,
                  borderColor: isAddressEntered ? AppColor.blue : AppColor.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}