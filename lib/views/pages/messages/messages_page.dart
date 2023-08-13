import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/views/widgets/message_card.dart';

import '../../../controllers/message/message_controller.dart';
import '../../../models/message/message_model.dart';
import '../../../models/user/user_model.dart';

class MessagesScreen extends StatefulWidget {
  final User user;

  MessagesScreen({required this.user});
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final MessageController _messageController = MessageController();
  final TextEditingController _messageTextController = TextEditingController();
  List<ChatMessage> _messages = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _fetchMessages() async {
    try {
      final messages = await _messageController.getMessages();
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  Future<void> _sendMessage(String message) async {
    try {
      final sender = widget.user.username;
      await _messageController.sendMessage(sender, message);
      _messageTextController.clear();
      _fetchMessages();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        toolbarHeight: 90,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryClr,
        title: Text('Community Chat', style: appBartitleStyle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                // reverse: true,
                controller: _scrollController,

                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return MessageCard(message: message);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryClr),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryClr),
                      ),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      if (_messageTextController.text.isNotEmpty) {
                        _sendMessage(_messageTextController.text);
                      }
                    },
                    child: Text(
                      'send',
                      style: paraStyleBB,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
