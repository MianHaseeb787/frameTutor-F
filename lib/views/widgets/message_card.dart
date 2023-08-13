import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
// import 'package:your_project/models/chat_message.dart';

import '../../models/message/message_model.dart'; // Import your ChatMessage model

class MessageCard extends StatelessWidget {
  final ChatMessage message;

  const MessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 223, 214, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: paraStyleBB,
          ),
          SizedBox(height: 5),
          Text(
            message.message,
            style: paraStyleB,
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              message.timestamp.toString(),
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 95, 94, 94)),
            ),
          ),
        ],
      ),
    );
  }
}
