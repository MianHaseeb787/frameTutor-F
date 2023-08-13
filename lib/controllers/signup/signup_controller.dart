import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../controllers/course/course_controller.dart';
import '../../models/course/course_model.dart';
import '../../models/user/user_model.dart';
import '../../services/services.dart';

final _courseController = CourseController();

Future<Course?> _fetchCourse() async {
  try {
    Course crs = await _courseController.getCourseById();
    return crs;
  } catch (e) {
    // Handle errors if necessary
    print('Failed to fetch course: $e');
  }
  return null;
}

class SignUpController {
  // static const String baseUrl = 'http://192.168.1.17:8080/users';

  Future<User> signupUser(String username, String email, String password,
      BuildContext context) async {
    final url = Uri.parse('$baseUrl/users/signUp');

    try {
      final Course? enrollCourse = await _fetchCourse();

      // Await the result of _fetchCourse()

      final response = await http.post(
        url,
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'enrolledCourse':
              enrollCourse?.toJson(), // Convert the Course object to JSON
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 201) {
        // User successfully signed up, parse the response JSON to create a User object
        final Map<String?, dynamic> jsonData = jsonDecode(response.body);
        // print(jsonData['user']);

        print(response.statusCode);
        // final snackBar = SnackBar(content: Text(response.body.toString()));
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return User.fromJson(jsonData['user']);
      } else {
        final data = jsonDecode(response.body);
        // Handle errors, such as user already exists, invalid data, etc.
        final snackBar = SnackBar(content: Text(data['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] as String;
        throw Exception('Sign up failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle connection errors or other exceptions
      String errorMessage = 'An error occurred during sign up.';

      if (e is Exception) {
        errorMessage = e.toString();
      }

      throw Exception('Error during sign up: $e');
    }
  }
}
