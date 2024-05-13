import 'package:capstone2_clean_house/components/button/td_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/order_booking_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskViewEmployeeDetail extends StatefulWidget {
  const TaskViewEmployeeDetail({
    super.key,
    required this.orderDetails,
  });

  final OrderDetailsModel orderDetails;

  @override
  State<TaskViewEmployeeDetail> createState() => _TaskViewEmployeeDetailState();
}

class _TaskViewEmployeeDetailState extends State<TaskViewEmployeeDetail> {
  final OrderBookingServices _orderBookingServices = OrderBookingServices();
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  bool _isProcessing = false;
  late int currentStatusId = orderDetailsModel.status_id ?? 0;

  Future<void> _handleDoneTaskButton() async {
    if (widget.orderDetails.status_id != 2) {
      bool confirmUpdate = await _confirmUpdateTaskDialog();
      if (confirmUpdate) {
        setState(() {
          _isProcessing = true;
        });
        final response = await _orderBookingServices
            .updateOrderStatus(widget.orderDetails.order_id ?? 0);

        setState(() {
          _isProcessing = false;
        });
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(child: Text('Update Successful Task!')),
            backgroundColor: Colors.blue,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(child: Text('Update Failed Task!')),
            backgroundColor: Colors.red,
          ));
          setState(() {});
        }
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: Text(
          'Task View Detail',
          style: GoogleFonts.dmSerifText(
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
                              'Area',
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
                              widget.orderDetails.estimated_time ?? '',
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
                                'Status Bill:',
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
                                    'Processing',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.orange,
                                    ),
                                  )
                                : widget.orderDetails.status_id == 2
                                    ? const Text(
                                        'Success Payment',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.green,
                                        ),
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Status Payment',
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
                              'Payment Method:',
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
                _appElevatedButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _appElevatedButton() {
    if (widget.orderDetails.status_id != 2) {
      return SizedBox(
        height: 60.0,
        width: 300.0,
        child: TdElevatedButton.fullmau(
          text: 'Done Task Order',
          fontSize: 17.0,
          color: Colors.blue,
          highlightColor: Colors.amber,
          splashColor: Colors.pink,
          borderColor: Colors.black.withOpacity(0.3),
          onPressed: _isProcessing ? null : _handleDoneTaskButton,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  _confirmUpdateTaskDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            "Confirm",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23.0,
            ),
          )),
          content:
              const Text("Are you sure you want to update the task as done?"),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
