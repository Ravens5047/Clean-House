import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capstone2_clean_house/pages/notifications/notification_service.dart';
import 'package:capstone2_clean_house/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTask extends StatefulWidget {
  final List<Map<String, String>> initialNotifications;

  const NotificationTask({super.key, required this.initialNotifications});

  @override
  State<NotificationTask> createState() => _NotificationTaskState();
}

class _NotificationTaskState extends State<NotificationTask> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    notifications = widget.initialNotifications;
    _loadNotifications();
  }

  void _loadNotifications() async {
    List<Map<String, String>> loadedNotifications =
        await SharedPrefs.getNotifications();
    setState(() {
      notifications.addAll(loadedNotifications);
    });
  }

  void addNotification(String title, String message) {
    setState(() {
      notifications.add({
        'title': title,
        'message': message,
      });
      SharedPrefs.saveNotifications(notifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Awesome Notification',
          style: GoogleFonts.dmSerifText(
            fontSize: 24.0,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  var notification = notifications[index];
                  return Card(
                    child: ListTile(
                      onTap: () async {
                        await NotificationServices.showNotification(
                          title: notification['title'] ?? '',
                          body: notification['message'] ?? '',
                          actionButtons: [
                            NotificationActionButton(
                              key: 'action_btn',
                              label: 'Action Button',
                            )
                          ],
                        );
                      },
                      leading: const Icon(Icons.notifications_sharp),
                      title: Center(
                        child: Text(notification['title'] ?? ''),
                      ),
                      subtitle: Center(
                        child: Text(notification['message'] ?? ''),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
