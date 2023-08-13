import 'package:flutter/material.dart';
import 'package:frametutor/views/pages/Home/Navbar_page.dart';
import 'package:frametutor/views/pages/signup/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/colors.dart';
import '../../../consts/fonts.dart';
import '../../../controllers/login/signin_controller.dart';
import '../../../models/user/user_model.dart';
import '../Onboarding/onboarding_page.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _signInController = SignInController();
  final _formKey = GlobalKey<FormState>();

  bool _signedIn = false; // Track if user is signed in

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) {
      return; // If form validation fails, don't proceed
    }

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      User _user = await _signInController.signIn(email, password);
      print('user signed in successfully, ${_user.id}');

      setState(() {
        _signedIn = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('login', true);
      prefs.setString('email', _user.email);

      _navigateToHomeScreen(_user); // Navigate to the HomeScreen
    } catch (e) {
      print(e);
    }
  }

  void _navigateToHomeScreen(User user) {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return HomeScreen(user: user);
    //     },
    //   ),
    //   (route) => false, // Remove all previous routes from the stack
    // );

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Welcome back',
                        style: titleStyleB,
                      ),
                      Text(
                        "Sign in to start learning",
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
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //           borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 66, 198, 165))),
                      //       disabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //           borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 0, 0, 0))),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //           borderSide:
                      //               BorderSide(width: 2, color: primaryClr)),

                      //       // labelText: 'Username',
                      //       hintText: 'Username',
                      //       hintStyle: paraStyleB,

                      //       // prefixIcon: Icon(Icons.person),
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //           borderSide:
                      //               BorderSide(width: 10, color: Colors.black))),
                      // ),
                      // SizedBox(height: 20),
                      // Email TextFormField
                      TextFormField(
                        controller: _emailController,
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
                      SizedBox(height: 20),
                      // Password TextFormField
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
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
                            hintText: 'Password',
                            hintStyle: paraStyleB,

                            // prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 10, color: Colors.black))),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          _handleSignIn();
                        },
                        child: Text(
                          'Sign in',
                          style: paraStyle,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                        'if you have not an account',
                        style: paraStyleB,
                      )),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: btnStyle,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Color.fromARGB(255, 225, 218, 249),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
