import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/pages/payment/confirm_payment.dart';
import 'package:capstone2_clean_house/pages/widget/Time%20Calendar/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class BookingServicesSelectionTimeWorking extends StatefulWidget {
  const BookingServicesSelectionTimeWorking({super.key});

  @override
  State<BookingServicesSelectionTimeWorking> createState() =>
      _BookingServicesSelectionTimeWorkingState();
}

class _BookingServicesSelectionTimeWorkingState
    extends State<BookingServicesSelectionTimeWorking> {
  final buttonWidth = 250.0;
  late Time _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = Time(hours: 0, minutes: 0);
  }

  void _openTimePicker(BuildContext context) {
    BottomPicker.time(
      pickerTitle: const Center(
        child: Text(
          'Set your next meeting time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
      ),
      onSubmit: (selectedDateTime) {
        setState(() {
          _selectedTime = Time(
              hours: selectedDateTime.hour, minutes: selectedDateTime.minute);
        });
        print(
            '${_selectedTime.hours} hours : ${_selectedTime.minutes} minutes');
      },
      onClose: () {
        print('Picker closed');
      },
      bottomPickerTheme: BottomPickerTheme.blue,
      use24hFormat: true,
      initialTime: _selectedTime,
      maxTime: Time(hours: 17),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        title: const Text(
          'Time Working',
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _mainExample(),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  const Ikonate(
                    Ikonate.timer,
                    color: AppColor.black,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'Work Time',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 220.0,
                    child: ElevatedButton(
                      onPressed: () {
                        _openTimePicker(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white.withOpacity(0.8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_selectedTime.hours} hours | ${_selectedTime.minutes} minutes',
                            style: const TextStyle(
                              color: AppColor.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                color: AppColor.blue,
                thickness: 1.0,
                indent: 50.0,
                endIndent: 50.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Note for the Tasker',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 17.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SelectionHouseTextField(
                  // controller: typeHouseController,
                  hintText:
                      'Do you have any additional requests? Please \nenter them here',
                  textInputAction: TextInputAction.done,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TdElevatedButton.fullmau(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ConfirmPayment()),
                    );
                  },
                  text: 'Continue',
                  color: AppColor.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

EasyDateTimeLine _mainExample() {
  return EasyDateTimeLine(
    initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
      //`selectedDate` the new date selected.
    },
  );
}
