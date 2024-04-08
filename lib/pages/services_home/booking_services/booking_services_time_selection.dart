// import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
// import 'package:capstone2_clean_house/components/text_field/note_text_field.dart';
// import 'package:capstone2_clean_house/components/text_field/selection_time_sized.dart';
// import 'package:capstone2_clean_house/model/services_model.dart';
// import 'package:capstone2_clean_house/pages/services_home/booking_services/booking_services_selection_time_working.dart';
// import 'package:capstone2_clean_house/resources/app_color.dart';
// import 'package:flutter/material.dart';

// class TimeSelection extends StatefulWidget {
//   const TimeSelection({super.key});

//   @override
//   State<TimeSelection> createState() => _TimeSelectionState();
// }

// class _TimeSelectionState extends State<TimeSelection> {
//   ServicesModel services = ServicesModel();
//   List<bool> isSelected = [false, false, false];
//   int? selectTime;
//   final formKey = GlobalKey<FormState>();

//   void handleFrequencySelection(int index) {
//     setState(() {
//       if (selectTime == index) {
//         selectTime = null;
//       } else {
//         selectTime = index;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.white,
//         title: const Text(
//           'Time Selection',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: Form(
//         key: formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Area',
//                 style: TextStyle(
//                   fontSize: 17.0,
//                   fontWeight: FontWeight.w400,
//                   color: AppColor.black,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               const Text(
//                 'Please provide an accurate estimate of the area requirement cleanup',
//                 style: TextStyle(
//                   fontSize: 15.0,
//                   fontWeight: FontWeight.w400,
//                   color: AppColor.black,
//                 ),
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   handleFrequencySelection(0);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SelectionTime(
//                     text: 'Max 80m² \n\nMax 2 people / 4 hours',
//                     isSelected: selectTime == 0,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   handleFrequencySelection(1);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SelectionTime(
//                     text: 'Max 80m² \n\nMax 2 people / 4 hours',
//                     isSelected: selectTime == 1,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   handleFrequencySelection(2);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SelectionTime(
//                     text: 'Max 80m² \n\nMax 2 people / 4 hours',
//                     isSelected: selectTime == 2,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               NoteTextField(
//                 text:
//                     '! You should choose the number of Taskers first. Working time will depend on actual workload. Before starting work, you can discuss with the tasker and adjust the time accordingly.',
//               ),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               const SizedBox(
//                 height: 100.0,
//               ),
//               //Bottom Sheet Dialog
//               TdElevatedButton.fullmau(
//                 text: 'Continue',
//                 color: AppColor.blue,
//                 borderColor: AppColor.blue,
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           const BookingServicesSelectionTimeWorking(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
