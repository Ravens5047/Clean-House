import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/pages/payment/confirm_payment.dart';
import 'package:capstone2_clean_house/pages/widget/Time%20Calendar/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class BookingServicesSelectionTimeWorking extends StatefulWidget {
  const BookingServicesSelectionTimeWorking({super.key});

  @override
  State<BookingServicesSelectionTimeWorking> createState() =>
      _BookingServicesSelectionTimeWorkingState();
}

class _BookingServicesSelectionTimeWorkingState
    extends State<BookingServicesSelectionTimeWorking> {
  @override
  Widget build(BuildContext context) {
    Time time = Time(hour: 8, minute: 0, second: 0);
    bool iosStyle = true;

    void onTimeChanged(Time newTime) {
      setState(() {
        time = newTime;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        title: const Text('Time Working'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const SizedBox(
            //   height: 32.0,
            // ),
            // const EasyInfiniteDateTimeLineExample(),
            // const Divider(
            //   height: 32,
            // ),
            _mainExample(),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              "Inline Picker Style",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: 400,
              height: 380,
              child: showPicker(
                isInlinePicker: true,
                elevation: 1,
                value: time,
                onChange: onTimeChanged,
                minuteInterval: TimePickerInterval.FIVE,
                iosStylePicker: iosStyle,
                minHour: 8,
                maxHour: 17,
                is24HrFormat: true,
                isOnChangeValueMode: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SelectionHouseTextField(
                // controller: typeHouseController,
                hintText: 'Add Address to House',
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(
              height: 20.0,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  EasyDateTimeLine _mainExample() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
      },
    );
  }
}

// class EasyInfiniteDateTimeLineExample extends StatefulWidget {
//   const EasyInfiniteDateTimeLineExample({super.key});

//   @override
//   State<EasyInfiniteDateTimeLineExample> createState() =>
//       _EasyInfiniteDateTimeLineExampleState();
// }
// 
// class _EasyInfiniteDateTimeLineExampleState
//     extends State<EasyInfiniteDateTimeLineExample> {
//   final EasyInfiniteDateTimelineController _controller =
//       EasyInfiniteDateTimelineController();
//   DateTime? _focusDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         EasyInfiniteDateTimeLine(
//           selectionMode: const SelectionMode.autoCenter(),
//           controller: _controller,
//           firstDate: DateTime(2024),
//           focusDate: _focusDate,
//           lastDate: DateTime(2024, 12, 31),
//           onDateChange: (selectedDate) {
//             setState(() {
//               _focusDate = selectedDate;
//             });
//           },
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 _controller.animateToFocusDate();
//               },
//               child: const Text('Animate To Focus Date'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _controller.animateToCurrentData();
//               },
//               child: const Text('Animate To Current Date'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _controller.animateToDate(DateTime(2024, 6, 5));
//               },
//               child: const Text('Animate To 2024-6-5 '),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
