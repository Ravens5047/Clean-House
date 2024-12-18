import 'package:capstone2_clean_house/components/app_bar/bottom_navigator_bar.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({
    super.key,
    this.result,
    this.payment,
    this.status_payment,
    required this.notifications,
  });

  final String? result;
  final String? payment;
  final String? status_payment;
  final List<Map<String, String>> notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                result == '00' ? Icons.check_circle : Icons.error,
                color: result == '00' ? Colors.green : Colors.red,
                size: 100.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                result == '00' ? 'Booking Successful' : 'Booking Failed',
                style: GoogleFonts.dmSerifText(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Payment Method: $payment',
              style: const TextStyle(fontSize: 16.0),
            ),
            // const SizedBox(height: 20.0),
            // Text(
            //   'Status: $status_payment',
            //   style: const TextStyle(fontSize: 16.0),
            // ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30.0,
                  ),
                  for (var notification in notifications)
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.notifications_sharp),
                            title: Center(
                              child: Text(
                                notification['title'] ?? '',
                              ),
                            ),
                            subtitle: Center(
                              child: Text(
                                notification['message'] ?? '',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(
                                    initialNotifications: notifications,
                                  ),
                                ),
                              );
                              await SharedPrefs.saveNotifications(
                                notifications,
                              );
                            },
                            child: SizedBox(
                              height: 60.0,
                              width: 60.0,
                              child: Lottie.asset(
                                'assets/house_icon.json',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
