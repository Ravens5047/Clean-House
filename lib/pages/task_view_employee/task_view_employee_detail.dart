import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/model/order_details_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';
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
          'Task View Detail',
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
                              widget.orderDetails.work_date ?? '',
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
                                'Status Bill',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            widget.orderDetails.status_id == 1
                                ? const Ikonate(
                                    Ikonate.checkbox,
                                    color: AppColor.red,
                                    width: 30.0,
                                  )
                                : widget.orderDetails.status_id == 2
                                    ? const Ikonate(
                                        Ikonate.checkbox,
                                        color: AppColor.green,
                                        width: 30.0,
                                      )
                                    : const SizedBox(),
                          ],
                        ),
                        const Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Status Payment',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                            Spacer(),
                            Ikonate(
                              Ikonate.checkbox,
                              color: AppColor.green,
                              width: 30.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
