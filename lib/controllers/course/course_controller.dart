import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/course/course_model.dart';
import '../../services/services.dart';

class CourseController {
  final String url = '$baseUrl'; // Replace with your API base URL

  Future<Course> getCourseById() async {
    // final url = 'https://your-api-url.com/courses/$courseId'; // Replace with your API URL

    try {
      final response =
          await http.get(Uri.parse('$baseUrl/courses/enrollCourse'));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final course = Course.fromJson(
            decodedData); // Create a method in your Course model to parse the JSON data
        return course;
      } else if (response.statusCode == 404) {
        throw Exception('Course not found.');
      } else {
        throw Exception('Error fetching course.');
      }
    } catch (error) {
      throw Exception('Error fetching course: $error');
    }
  }

  Future<List<Course>> getAllCourses() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/courses/'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        // print('addded');
        return jsonData.map((course) => Course.fromJson(course)).toList();
      } else {
        // Handle errors if necessary
        throw Exception(
            'Failed to fetch courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions or errors that occurred during the API call
      throw Exception('Failed to fetch courses: $e');
    }
  }
}
