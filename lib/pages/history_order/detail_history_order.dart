import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/components/text_field/selection_house_text_field.dart';
import 'package:capstone2_clean_house/pages/payment/select_payment.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';

class DetailHistoryOrder extends StatefulWidget {
  const DetailHistoryOrder({super.key});

  @override
  State<DetailHistoryOrder> createState() => _DetailHistoryOrderState();
}

class _DetailHistoryOrderState extends State<DetailHistoryOrder> {
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
          'Detail History Order',
          style: GoogleFonts.mandali(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '#001',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Nguyen Hoang Hung',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '162/5 Dong Da',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Phone',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '0906436495',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'House Type',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'House / Town House',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Area',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Max 15m²',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Work Date',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '11/04/2024',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Start Time',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '14:22',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Align(
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
                          Spacer(),
                          Text(
                            '100,000 VND',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Align(
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
                          Spacer(),
                          Ikonate(
                            Ikonate.checkbox,
                            color: AppColor.red,
                            width: 30.0,
                          ),
                        ],
                      ),
                      Row(
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
                      Text(
                        'Note Tasker',
                        style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SelectionHouseTextField(
                          // controller: NoteController,
                          hintText:
                              'Do you have any additional requests? Please \nenter them here',
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              SizedBox(
                height: 200.0,
                width: 400.0,
                child: Center(
                  child: AppElevatedButton.normal1(
                    text: 'Payment',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectPayment(
                            total_price: 10000,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
