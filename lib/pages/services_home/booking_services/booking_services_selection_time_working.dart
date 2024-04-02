import 'package:capstone2_clean_house/pages/widget/Time%20Calendar/easy_date_timeline_widget/easy_date_timeline_widget.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
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
          children: [
            // const SizedBox(
            //   height: 32.0,
            // ),
            // // const EasyInfiniteDateTimeLineExample(),
            // const Divider(
            //   height: 32,
            // ),
            _mainExample(),
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
