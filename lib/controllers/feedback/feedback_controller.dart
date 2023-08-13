import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:your_app/models/feedback_model.dart';

import '../../models/feedback/feedback.dart';
import '../../services/services.dart';

class FeedbackController {
  // Replace with your API URL

  // Method to send feedback
  static Future<void> sendFeedback(
      String username, String comment, int rating) async {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'comment': comment,
        'rating': rating,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send feedback');
    }
  }

  // Method to get all feedback
  static Future<List<Feedback>> getAllFeedback() async {
    final response = await http.get(Uri.parse('$baseUrl/feedback'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Feedback.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch feedback');
    }
  }
}
