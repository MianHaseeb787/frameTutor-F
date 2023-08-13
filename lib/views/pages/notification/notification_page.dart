import 'package:flutter/material.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/views/widgets/notification_card.dart';
import 'package:intl/intl.dart'; // Import the DateFormat class
import '../../../controllers/notification/notification.dart';
import '../../../models/notification/notification.dart';
// import '../../models/notification.dart'; // Import your Notification model
// import '../../controllers/notification_controller.dart'; // Import your NotificationController

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notifications;

  NotificationController _notificationController = NotificationController();

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    _notifications = _notificationController.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Notifications',
          style: appBartitleStyleB,
        ),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications found.'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];
                  return NotificationCard(notification: notification);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
