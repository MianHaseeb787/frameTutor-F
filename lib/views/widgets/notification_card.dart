import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:intl/intl.dart';
// import 'package:your_project/models/chat_message.dart';

import '../../models/notification/notification.dart';
// Import your ChatMessage model

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 214, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.notification.username,
            style: paraStyleBB,
          ),
          SizedBox(height: 5),
          Text(
            widget.notification.content,
            style: paraStyleB,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat('MMM d, y, h:mm a')
                  .format(widget.notification.timestamp),
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 95, 94, 94)),
            ),
          ),
        ],
      ),
    );
  }
}
