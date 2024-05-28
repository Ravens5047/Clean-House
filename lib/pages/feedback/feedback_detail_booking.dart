import 'dart:convert';
import 'package:capstone2_clean_house/model/feedback_model.dart';
import 'package:capstone2_clean_house/resources/app_color.dart';
import 'package:capstone2_clean_house/services/remote/feedback_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackDetailBooking extends StatefulWidget {
  const FeedbackDetailBooking({super.key});

  @override
  State<FeedbackDetailBooking> createState() => _FeedbackDetailBookingState();
}

class _FeedbackDetailBookingState extends State<FeedbackDetailBooking> {
  final formKey = GlobalKey<FormState>();
  FeedbackServiceAPI feedbackServiceAPI = FeedbackServiceAPI();
  FeedbackRequestModel feedbackRequestModel = FeedbackRequestModel();
  List<FeedbackRequestModel> feedbackDetailsList = [];

  @override
  void initState() {
    super.initState();
    _getlistFeedback();
    _reloadUI();
  }

  void _getlistFeedback() {
    feedbackServiceAPI.getFeedbackAll().then((response) {
      if (response.statusCode == 200) {
        List<FeedbackRequestModel> tempList = [];
        List<dynamic> responseData = jsonDecode(response.body);
        for (var data in responseData) {
          FeedbackRequestModel feedback = FeedbackRequestModel.fromJson(data);
          tempList.add(feedback);
        }
        print('Connection successfully Call API');
        setState(() {
          feedbackDetailsList = tempList;
        });
      } else {
        print('Failed to load data from API');
      }
    }).catchError((onError) {
      print('Error occurred: $onError');
    });
  }

  void _reloadUI() {
    _getlistFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Booking'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _reloadUI();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: feedbackDetailsList.isEmpty
              ? const Center(
                  child: Text(
                    'No Feedback available',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: feedbackDetailsList.length,
                  itemBuilder: (context, index) {
                    final feedbackDetails = feedbackDetailsList[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 5.0,
                        ),
                        child: Container(
                          height: 170.0,
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
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Full Name: ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    Text(
                                      feedbackDetails.full_name.toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Content Feedback: ',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    Text(
                                      feedbackDetails.content.toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Center(
                                  child: RatingBarIndicator(
                                    rating: feedbackDetails.rating!.toDouble(),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: AppColor.orange,
                                    ),
                                    itemCount: 5,
                                    itemSize: 30.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
