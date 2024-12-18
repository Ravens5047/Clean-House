import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/pages/feedback/feedback_screen.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({
    super.key,
    required this.orderDetails,
    this.order_details_id,
  });

  final OrderDetailsModel orderDetails;
  final int? order_details_id;

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
  final formKey = GlobalKey<FormState>();
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();

  DateTime? addOneDay(DateTime? date) {
    if (date != null) {
      return date.add(const Duration(days: 1));
    }
    return null;
  }

  DateTime? parseDate(String? dateStr) {
    try {
      if (dateStr != null) {
        return DateFormat('yyyy-MM-dd').parse(dateStr);
      }
    } catch (e) {
      print('Invalid date format: $dateStr');
    }
    return null;
  }

  String formatTime(String? timeStr) {
    if (timeStr != null) {
      try {
        final parsedTime = DateFormat('HH:mm:ss').parse(timeStr);
        return DateFormat('HH:mm').format(parsedTime);
      } catch (e) {
        print('Invalid time format: $timeStr');
      }
    }
    return '';
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
        title: Text(
          'Detail History Booking',
          style: GoogleFonts.mandali(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        offset: Offset(0.0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '#${widget.orderDetails.order_detail_id.toString()}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.full_name ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Address',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.address_order ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Phone',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.phone_number ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'House Type',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.houseType ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'House Area',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.area ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Work Date',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              addOneDay(parseDate(
                                          widget.orderDetails.work_date)) !=
                                      null
                                  ? DateFormat('yyyy-MM-dd').format(addOneDay(
                                      parseDate(
                                          widget.orderDetails.work_date))!)
                                  : '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Start Time',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.start_time ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Estimated Time',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formatTime(widget.orderDetails.estimated_time),
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Totals',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${NumberFormat('#,##0', 'en_US').format(widget.orderDetails.sub_total_price)} VND',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Status: ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            widget.orderDetails.status_id == 1
                                ? const Text(
                                    'Pending confirmation',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.orange,
                                    ),
                                  )
                                : widget.orderDetails.status_id == 2
                                    ? const Text(
                                        'In Progress',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.green,
                                        ),
                                      )
                                    : widget.orderDetails.status_id == 3
                                        ? const Text(
                                            'Completed',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.blue,
                                            ),
                                          )
                                        : const SizedBox(),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Status Payment:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.status_payment ?? '',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: widget.orderDetails.status_payment ==
                                        'Processing'
                                    ? Colors.black
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Method Payment:',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.orderDetails.payment ?? '',
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Note Tasker',
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectionHouseTextField(
                            // controller: NoteController,
                            hintText: widget.orderDetails.note ?? '',
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                if (widget.orderDetails.status_id == 3)
                  AppElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FeedbackScreen(
                          service_id: widget.orderDetails.service_id,
                          fullname: widget.orderDetails.full_name,
                          order_details_id: widget.orderDetails.order_detail_id,
                        ),
                      ),
                    ),
                    text: 'Feedback',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
