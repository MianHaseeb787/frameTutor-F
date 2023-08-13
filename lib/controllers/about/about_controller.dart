import 'dart:convert';
import 'package:frametutor/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:frametutor/models/about/about_model.dart';

class AboutController {
  final url = baseUrl;
  static Future<About> fetchAbout() async {
    final response = await http.get(Uri.parse('$baseUrl/about/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return About.fromJson(data);
    } else {
      throw Exception('Failed to fetch About data');
    }
  }
}
