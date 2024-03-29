import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';

class TaskViewEmployeeDetail extends StatefulWidget {
  const TaskViewEmployeeDetail({super.key});

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
        title: const Text(
          'Task View Detail',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
            color: AppColor.blue,
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
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(
                  color: AppColor.black,
                  width: 2,
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
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Living Room: 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '25\$',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bath Room: 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '25\$',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kitchen Room: 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '25\$',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bed Room: 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '25\$',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ],
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
          ],
        ),
      ),
    );
  }
}
