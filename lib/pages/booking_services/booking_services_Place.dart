// ignore_for_file: file_names
import 'dart:async';
import 'package:capstone2_clean_house/components/button/selection_house_type.dart';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/app_text_field_profile.dart';
import 'package:capstone2_clean_house/components/text_field/note_text_field.dart';
import 'package:capstone2_clean_house/components/text_field/selection_time_sized.dart';
import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/model/google_map_model.dart';
import 'package:capstone2_clean_house/pages/booking_services/booking_services_selection_time_working.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BookingServicesPlace extends StatefulWidget {
  const BookingServicesPlace({
    super.key,
    required this.service_name,
    required this.service_id,
  });

  final String service_name;
  final int service_id;

  @override
  State<BookingServicesPlace> createState() => _BookingServicesPlaceState();
}

class _BookingServicesPlaceState extends State<BookingServicesPlace> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController typeHouseController = TextEditingController();
  TextEditingController typeNumberController = TextEditingController();
  String? selectedLocation;
  List<bool> isSelected = [false, false, false];
  int? selectedHouse;
  int? selectedArea;
  GoogleMapModel selectedShop = GoogleMapModel();
  bool isAddressEntered = false;
  final formKey = GlobalKey<FormState>();
  AppUsersModel appUsersModel = AppUsersModel();
  late String? phoneNumber;
  late String? address_user;
  bool _isFormSubmitted = false;
  static const int houseTownhousePrice = 7040;
  static const int apartmentPrice = 8200;
  static const int villasPrice = 9000;

  double calculateTotal() {
    double price = 0.0;
    if (selectedHouse != null && selectedArea != null) {
      double area = 0.0;
      switch (selectedArea) {
        case 0:
          area = 15.0;
          break;
        case 1:
          area = 25.0;
          break;
        case 2:
          area = 40.0;
          break;
        case 3:
          area = 60.0;
          break;
        case 4:
          area = 80.0;
          break;
        case 5:
          area = 100.0;
          break;
      }

      switch (selectedHouse) {
        case 0:
          price = houseTownhousePrice * area;
          break;
        case 1:
          price = apartmentPrice * area;
          break;
        case 2:
          price = villasPrice * area;
          break;
      }
    }
    String formattedPrice = NumberFormat("#,##0", "en_US").format(price);
    print("Formatted Price: $formattedPrice");
    return price;
  }

  @override
  void initState() {
    super.initState();
    _setPhoneNumberFromPrefs();
    _checkPhoneNumberFromPrefs();
  }

  Future<void> _setPhoneNumberFromPrefs() async {
    phoneNumber = SharedPrefs.phoneNumber;
    if (phoneNumber != null) {
      setState(() {
        typeNumberController.text = phoneNumber!;
      });
    }
  }

  void _checkPhoneNumberFromPrefs() async {
    String? storedPhoneNumber = SharedPrefs.phoneNumber;
    if (storedPhoneNumber != null) {
      print('Stored phone number: $storedPhoneNumber');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number is not stored in shared_prefs.'),
        ),
      );
    }
  }

  void handleFrequencySelection(int index) {
    setState(() {
      if (selectedHouse == index) {
        selectedHouse = null;
      } else {
        selectedHouse = index;
      }
    });
  }

  void handleFrequencySelectionArea(int index) {
    setState(() {
      if (selectedArea == index) {
        selectedArea = null;
      } else {
        selectedArea = index;
      }
    });
  }

  void handleTextFieldsChanged(String value) {
    setState(() {
      isAddressEntered = fullnameController.text.isNotEmpty &&
          typeHouseController.text.isNotEmpty &&
          phoneNumberController.text.length == 10;
    });
  }

  String? fullnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter full name';
    }
    return null;
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
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  void _validateAndSubmitForm() {
    setState(() {
      _isFormSubmitted = true;
    });
    if (selectedHouse == null || selectedArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Center(
            child: Text(
              'Please select house type and area.',
            ),
          ),
        ),
      );
      Timer(const Duration(milliseconds: 500), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      return;
    }
    if (formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookingServicesSelectionTimeWorking(
            selectedHouse: selectedHouse,
            selectedArea: selectedArea,
            address: typeHouseController.text,
            fullname: fullnameController.text,
            phone_number: phoneNumberController.text,
            service_name: widget.service_name,
            total_price: calculateTotal(),
            service_id: widget.service_id,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selection Work Locations',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  controller: fullnameController,
                  hintText: 'Full Name',
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    setState(() {
                      isAddressEntered = value.isNotEmpty;
                    });
                  },
                  onTextChanged: handleTextFieldsChanged,
                  validator: fullnameValidator,
                  errorText: _isFormSubmitted
                      ? fullnameValidator(fullnameController.text)
                      : null,
                ),
                const SizedBox(
                  height: 10.0,
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
                  errorText: _isFormSubmitted
                      ? addressValidator(typeHouseController.text)
                      : null,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                AppTextFieldProfile(
                  controller: phoneNumberController,
                  hintText: 'Phone Number',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: (value) {
                    setState(() {
                      isAddressEntered = value.isNotEmpty;
                    });
                  },
                  onTextChanged: handleTextFieldsChanged,
                  validator: phoneNumberValidator,
                  errorText: _isFormSubmitted
                      ? phoneNumberValidator(phoneNumberController.text)
                      : null,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Selection House Type',
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
                    '\n*Please selection type house, tasker easy searching for house.',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelection(0);
                  },
                  child: SelectionHouse(
                    text: 'House / Town House',
                    isSelected: selectedHouse == 0,
                    errorText: _isFormSubmitted && selectedHouse == null
                        ? 'Please select a house type'
                        : null,
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
                    errorText: _isFormSubmitted && selectedHouse == null
                        ? 'Please select a house type'
                        : null,
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
                    errorText: _isFormSubmitted && selectedHouse == null
                        ? 'Please select a house type'
                        : null,
                  ),
                ),
                const Divider(
                  indent: 30.0,
                  endIndent: 30.0,
                  thickness: 2.0,
                  height: 40.0,
                  color: Colors.blue,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Selection House Area',
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
                    '\n*Please provide an accurate estimate of the area requirement cleanup',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 15m² \n2 hours',
                      isSelected: selectedArea == 0,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 25m² \n2 hours',
                      isSelected: selectedArea == 1,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 40m² \n2 hours',
                      isSelected: selectedArea == 2,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(3);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 60m² \n4 hours',
                      isSelected: selectedArea == 3,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(4);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 80m² \n4 hours',
                      isSelected: selectedArea == 4,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    handleFrequencySelectionArea(5);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectionTime(
                      text: 'Max 100m² \n4 hours',
                      isSelected: selectedArea == 5,
                      errorText: _isFormSubmitted && selectedArea == null
                          ? 'Please select an area'
                          : null,
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
                Row(
                  children: [
                    const Text(
                      'Totals ',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${NumberFormat("#,##0", "en_US").format(calculateTotal())} VND ',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: _validateAndSubmitForm,
                  child: TdElevatedButton.fullmau(
                    text: 'Continue',
                    color: isAddressEntered ? Colors.blue : AppColor.grey,
                    borderColor: isAddressEntered ? Colors.blue : AppColor.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
