import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user/user_model.dart';
import '../../services/services.dart';

class UserController {
  static Future<User> getUserByEmail(String email) async {
    final url = Uri.parse('$baseUrl/users/find/user');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );
      print(email);

      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        print(User.fromJson(jsonData['user']));

        return User.fromJson(jsonData['user']);
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (error) {
      print('Error fetching user: $error');
      throw Exception('An error occurred while fetching user');
    }
  }

  Future<bool> fetchVideoCompletedStatus(String userId, int videoIndex) async {
    final url = Uri.parse(
        '$baseUrl/users/complete/status?userId=$userId&videoIndex=$videoIndex');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['completed'] as bool;
      } else {
        print('Error fetching video completed status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error fetching video completed status: $error');
      return false;
    }
  }

  Future<void> updateCompletedInDatabase(
      int videoIndex, String userId, bool completed) async {
    final url =
        '$baseUrl/users/video/completed'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    try {
      final body = json.encode({
        'videoIndex': videoIndex,
        'userId': userId,
        'completed': completed,
      });

      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);

      // print('HTTP Response: ${response.statusCode}');
      // print('HTTP Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Completed status updated successfully');
      } else {
        throw Exception('Failed to update completed status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateWatchTimeInDatabase(
      int videoIndex, String userId, int watchTime) async {
    // Replace with your API endpoint for updating watch time
    final apiUrl = '$baseUrl/users/watchTime/update';

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'videoIndex': videoIndex,
        'userId': userId,
        'watchTime': watchTime,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update watchTime in the database');
    }
  }

  Future<int> fetchWatchTimeFromServer(String userId, int videoIndex) async {
    final apiUrl = '$baseUrl/users/$videoIndex/watchTime?userId=$userId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['watchTime'];
    } else {
      throw Exception('Failed to fetch watchTime from the server');
    }
  }

  void updateMcqsScore(int newScore, String usrId) async {
    final userId = usrId; // Replace with the actual user ID
    final url =
        '$baseUrl/users/update/score'; // Replace with your backend API URL

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'newScore': newScore}),
    );

    if (response.statusCode == 200) {
      print('MCQs score updated successfully');
    } else {
      print('Failed to update MCQs score');
    }
  }

  void updateFlashcardMastered(
      bool newMasteredValue, int flashcardIndex, String userId) async {
    final url =
        '$baseUrl/users/update/card'; // Replace with your backend API URL

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'flashcardIndex': flashcardIndex,
        'newMasteredValue': newMasteredValue
      }),
    );

    if (response.statusCode == 200) {
      print('Flashcard mastered value updated successfully');
    } else {
      print('Failed to update flashcard mastered value');
    }
  }
}
