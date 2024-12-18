import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/snack_bar/td_snack_bar.dart';
import 'package:capstone2_clean_house/components/snack_bar/top_snack_bar.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/pages/payment/confirm_payment.dart';
import 'package:capstone2_clean_house/pages/widget/Time%20Calendar/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';

class BookingServicesSelectionTimeWorking extends StatefulWidget {
  const BookingServicesSelectionTimeWorking({
    super.key,
    this.selectedHouse,
    this.selectedArea,
    required this.address,
    required this.fullname,
    required this.total_price,
    required this.phone_number,
    required this.service_name,
    required this.service_id,
  });

  final int? selectedHouse;
  final int? selectedArea;
  final String address;
  final String fullname;
  final String phone_number;
  final String service_name;
  final double total_price;
  final int service_id;

  @override
  State<BookingServicesSelectionTimeWorking> createState() =>
      _BookingServicesSelectionTimeWorkingState();
}

class _BookingServicesSelectionTimeWorkingState
    extends State<BookingServicesSelectionTimeWorking> {
  final NoteController = TextEditingController();
  final buttonWidth = 250.0;
  late Time _selectedTime;
  late DateTime _selectedDate;
  int? selectedHouse;
  int? selectedArea;

  @override
  void initState() {
    super.initState();
    _selectedTime = _getCurrentTime();
    _selectedDate = DateTime.now();
    selectedHouse = widget.selectedHouse;
    selectedArea = widget.selectedArea;
  }

  Time _getCurrentTime() {
    final now = DateTime.now();
    return Time(
      hours: now.hour,
      minutes: now.minute,
    );
  }

  void _updateSelectedDate(DateTime newDate) {
    final currentDate = DateTime.now();
    // Chỉ chọn được trong hôm nay và ngày mai chứ không thể chọn ngày trước và ngày mốt
    //----------------------------------------------------------------
    // final tomorrowDate = currentDate.add(const Duration(days: 7));
    // if (newDate.isAfter(currentDate.subtract(const Duration(days: 1))) &&
    //     newDate.isBefore(tomorrowDate)) {
    //   setState(() {
    //     _selectedDate = newDate;
    //   });
    //----------------------------------------------------------------
    // Có thể selection date hôm nay và bất kì ngày nào miễn không phải ngày âm
    if (newDate.isAfter(
      currentDate.subtract(
        const Duration(days: 1),
      ),
    )) {
      setState(() {
        _selectedDate = newDate;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Invalid Date',
                style: GoogleFonts.dmSerifText(
                  color: AppColor.black,
                  fontSize: 20.0,
                ),
              ),
            ),
            content: const Text(
                'It is not possible to select negative and past dates from current dates\n\nPlease select a date between today and tomorrow.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _openTimePicker(BuildContext context) {
    Time startTime;
    Time endTime;
    if (selectedArea == 0 || selectedArea == 1 || selectedArea == 2) {
      startTime = Time(hours: 8, minutes: 0);
      endTime = Time(hours: 20, minutes: 0);
    } else {
      startTime = Time(hours: 8, minutes: 0);
      endTime = Time(hours: 20, minutes: 0);
    }
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
        if (selectedDateTime.hour >= startTime.hours &&
            selectedDateTime.hour < endTime.hours) {
          setState(() {
            _selectedTime = Time(
                hours: selectedDateTime.hour, minutes: selectedDateTime.minute);
          });
          print(
              '${_selectedTime.hours} hours : ${_selectedTime.minutes} minutes');
        } else if (selectedArea == 0 ||
            selectedArea == 1 ||
            selectedArea == 2) {
          showTopSnackBar(
            context,
            const TDSnackBar.error(
              message: "Please choose time 8:00 to 15:00.",
            ),
          );
        } else if (selectedArea == 3 ||
            selectedArea == 4 ||
            selectedArea == 5) {
          showTopSnackBar(
            context,
            const TDSnackBar.error(
              message: "Please choose time 8:00 to 13:00.",
            ),
          );
        } else {
          showTopSnackBar(
            context,
            const TDSnackBar.error(
              message: "Please choose a time invalid",
            ),
          );
        }
      },
      onClose: () {
        print('Picker closed');
      },
      bottomPickerTheme: BottomPickerTheme.blue,
      use24hFormat: true,
      initialTime: _selectedTime,
      minTime: startTime,
      maxTime: endTime,
    ).show(context);
  }

  String calculateEstimatedCompletionTime(int selectedArea, Time selectedTime) {
    if (selectedArea == 0 || selectedArea == 1 || selectedArea == 2) {
      return '${selectedTime.hours + 2}:${selectedTime.minutes.toString().padLeft(2, '0')}';
    } else {
      return '${selectedTime.hours + 4}:${selectedTime.minutes.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedArea = widget.selectedArea ?? 0;
    Time selectedTime = _selectedTime;
    String estimatedCompletionTime =
        calculateEstimatedCompletionTime(selectedArea, selectedTime);
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
                            '${_selectedTime.hours.toString().padLeft(2, '0')} hours | ${_selectedTime.minutes.toString().padLeft(2, '0')} minutes',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Estimated time to complete',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    estimatedCompletionTime,
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.blue,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectionHouseTextField(
                  controller: NoteController,
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
                        builder: (context) => ConfirmPayment(
                          selectedTime: _selectedTime,
                          selectedDate: _selectedDate,
                          selectedHouse: selectedHouse,
                          selectedArea: selectedArea,
                          address: widget.address,
                          fullname: widget.fullname,
                          phone_number: widget.phone_number,
                          service_name: widget.service_name,
                          note: NoteController.text,
                          total_price: widget.total_price,
                          service_id: widget.service_id,
                          static_id: 1,
                          estimated_time: estimatedCompletionTime,
                        ),
                      ),
                    );
                  },
                  highlightColor: Colors.orange,
                  text: 'Continue',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  EasyDateTimeLine _mainExample() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        _updateSelectedDate(selectedDate);
      },
    );
  }
}
