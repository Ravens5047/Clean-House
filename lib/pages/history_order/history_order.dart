import 'package:capstone2_clean_house/model/app_users_model.dart';
import 'package:capstone2_clean_house/pages/history_order/detail_history_order.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icony/icony_ikonate.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({super.key});

  @override
  State<HistoryOrder> createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  AppUsersModel appUser = AppUsersModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'History Order',
          style: GoogleFonts.mandali(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DetailHistoryOrder(),
                ),
              ),
              child: Container(
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
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name Service: Kitchen Cleaning',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Total Price: 100.00\$',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Method Payment: Cash',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Status Payment',
                              style: TextStyle(
                                fontSize: 18.0,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
