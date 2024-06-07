import 'package:flutter/material.dart';
import 'package:capstone2_clean_house/components/button/app_elevated_button.dart';
import 'package:capstone2_clean_house/model/feedback_model.dart';
import 'package:capstone2_clean_house/model/order_details_response_model.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:capstone2_clean_house/services/remote/feedback_services.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    this.order_details_id,
    this.service_id,
    this.fullname,
    super.key,
  });

  final int? service_id;
  final String? fullname;
  final int? order_details_id;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0;
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  bool _isSubmitting = false;
  bool _hasSubmittedFeedback = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We value your feedback! Please rate our service and leave a comment below:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: _buildRatingBar(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            _hasSubmittedFeedback
                ? _buildFeedbackSubmittedMessage()
                : _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 50.0,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildSubmitButton() {
    if (_hasSubmittedFeedback) {
      return _buildFeedbackSubmittedMessage();
    } else {
      return Center(
        child: AppElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () async {
                  if (_rating == 0 || _feedbackController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blue,
                        content: Center(
                          child: Text('Please provide a rating and feedback.'),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _isSubmitting = true;
                    });
                    final int? user_id = SharedPrefs.user_id;
                    if (user_id != null) {
                      final feedbackService = FeedbackServiceAPI();
                      final feedbackData = FeedbackRequestModel(
                        user_id: user_id,
                        rating: _rating,
                        content: _feedbackController.text,
                        service_id: widget.service_id,
                        full_name: widget.fullname,
                        order_detail_id: widget.order_details_id,
                      );
                      try {
                        final response =
                            await feedbackService.addFeedback(feedbackData);
                        if (response.statusCode == 200) {
                          _showFeedbackSuccessSnackBar();
                          setState(() {
                            _rating = 0;
                            _feedbackController.clear();
                            _isSubmitting = false;
                            _hasSubmittedFeedback = true;
                          });
                        }
                      } catch (e) {
                        debugPrint('Error submitting feedback: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.blue,
                            content: Center(
                              child: Text(
                                'An error occurred.',
                              ),
                            ),
                          ),
                        );
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.blue,
                          content: Center(
                            child: Text(
                              'User ID is not available.',
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        _isSubmitting = false;
                      });
                    }
                  }
                },
          borderColor: Colors.grey,
          text: _isSubmitting ? 'Submitting...' : 'Submit Feedback',
        ),
      );
    }
  }

  Widget _buildFeedbackSubmittedMessage() {
    return const Center(
      child: Text(
        'This order has been successfully submitted feedback. Thank you!',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  void _showFeedbackSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blue,
        content: Center(
          child: Text('Thank you for your feedback!'),
        ),
      ),
    );
  }
}
