import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/notification/notification.dart';
import '../../services/services.dart';
// import '../models/notification.dart';

class NotificationController {
  // Method to fetch all notifications
  Future<List<NotificationModel>> getAllNotifications() async {
    final response = await http.get(Uri.parse('$baseUrl/notification'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }
}
