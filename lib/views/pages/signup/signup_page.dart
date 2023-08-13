import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/views/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user/user_model.dart';
import '../../../controllers/signup/signup_controller.dart';
import '../Home/Navbar_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = SignUpController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _signedUp = false;
  final _formKey =
      GlobalKey<FormState>(); // Add a GlobalKey for form validation

  void _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return; // If form validation fails, don't proceed
    }

    final String username = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    try {
      User newUser =
          await signUpController.signupUser(username, email, password, context);

      setState(() {
        _signedUp = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('login', true);
      prefs.setString('email', newUser.email);

      _navigateToHomeScreen(newUser);
    } catch (e) {
      print(e);
    }
  }

  void _navigateToHomeScreen(User user) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(user: user);
        },
      ),
      (route) => false,
    );
  }

  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 640),
      minTextAdapt: true,
    );

    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey, // Attach the form key to the form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Create new Account',
                        style: titleStyleB,
                      ),
                      Text(
                        "Create new account if you don't have",
                        style: paraStyleB,
                      )
                    ],
                  ),
                ),
                // Username TextFormField
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 198, 165))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(width: 2, color: primaryClr)),

                            // labelText: 'Username',
                            hintText: 'username',
                            hintStyle: paraStyleB,

                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 10, color: Colors.black))),
                      ),
                      SizedBox(height: 20.h),
                      // Email TextFormField
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 198, 165))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(width: 2, color: primaryClr)),

                            // labelText: 'Username',
                            hintText: 'Email',
                            hintStyle: paraStyleB,

                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 10, color: Colors.black))),
                      ),
                      SizedBox(height: 20.h),
                      // Password TextFormField
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 198, 165))),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(width: 2, color: primaryClr)),

                            // labelText: 'Username',
                            hintText: 'Password',
                            hintStyle: paraStyleB,

                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 10, color: Colors.black))),
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        onPressed: () {
                          _handleSignUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: paraStyle,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Already have an account?',
                          style: paraStyleB,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignInScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: btnStyle,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color.fromARGB(255, 225, 218, 249),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
