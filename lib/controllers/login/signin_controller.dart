import 'dart:convert';
import 'dart:ffi';

import 'package:frametutor/services/services.dart';
import 'package:http/http.dart' as http;

import '../../models/user/user_model.dart';

class SignInController {
  Future<User> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/signIn');

    print('$url');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        // User successfully signed up, parse the response JSON to create a User object
        // print(response.body);
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print(jsonData);
        print(User.fromJson(jsonData['user']));

        return User.fromJson(jsonData['user']);

        // print(jsonData['user']);

        // return true;

        // print('Registration successful');
      } else {
        // Handle errors, such as user already exists, invalid data, etc.
        throw Exception('Sign up failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("error signing in, $e");
    }
  }
}
