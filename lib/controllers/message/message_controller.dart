import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:your_project/models/chat_message.dart';

import '../../models/message/message_model.dart';
import '../../services/services.dart'; // Import your ChatMessage model

class MessageController {
  MessageController();

  Future<void> sendMessage(String sender, String message) async {
    const apiUrl = '$baseUrl/message/send';

    final body = {
      'sender': sender,
      'message': message,
    };

    print(apiUrl);
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'username': sender,
        'message': message,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }

  Future<List<ChatMessage>> getMessages() async {
    final apiUrl = '$baseUrl/message/';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch messages');
    }

    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<ChatMessage> messages =
        jsonData.map((data) => ChatMessage.fromJson(data)).toList();

    return messages;
  }
}
