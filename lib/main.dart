// import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/controllers/user/user_controller.dart';
// import 'package:frametutor/cc.dart';
// import 'package:frametutor/consts/fonts.dart';
// import 'package:frametutor/views/pages/Course/coursedetails_page.dart';
// import 'package:frametutor/views/pages/Course/coursedetails_page.dart';
import 'package:frametutor/views/pages/Home/Navbar_page.dart';
import 'package:frametutor/views/pages/Navigationbar/bottomnavigationbar.dart';
import 'package:frametutor/views/pages/Onboarding/onboarding_page.dart';
import 'package:frametutor/views/pages/login/login_page.dart';
import 'package:frametutor/views/pages/signup/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user/user_model.dart';
// import 'package:frametutor/views/pages/Course/video/videos_page.dart';

Future<void> main() async {
  print('main');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);

  if (prefs.containsKey('email')) {
    User user = await UserController.getUserByEmail(email!);
    var login = prefs.getBool('login') ?? false;

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login ? HomeScreen(user: user) : SignInScreen(),
    ));
  } else {
    var onboard = prefs.getBool('onboard') ?? false;

    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onboard ? SignInScreen() : const MyApp(),
    ));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const OnBoardingPage();
    // MaterialApp(
    //     title: 'Flutter Demo',
    //     // initialRoute: '/onboard',
    //     routes: {
    //       '/onboard': (context) => OnBoardingPage(),
    //       '/signin': (context) => SignInScreen(),
    //       // '/signup': (context) => SignUpScreen(),
    //       // '/home': (context) => HomeScreen(),
    //       // '/main': (context) => HomeScreen(),
    //       // '/coursedetail': (context) => CourseDetailScreen(),
    //       '/navbar': (context) => MyNavigationBar(),
    //     },
    //     // color: Colors.amber,
    //     theme: ThemeData(
    //         // This is the theme of your application.
    //         //
    //         // Try running your application with "flutter run". You'll see the
    //         // application has a blue toolbar. Then, without quitting the app, try
    //         // changing the primarySwatch below to Colors.green and then invoke
    //         // "hot reload" (press "r" in the console where you ran "flutter run",
    //         // or simply save your changes to "hot reload" in a Flutter IDE).
    //         // Notice that the counter didn't reset back to zero; the application
    //         // is not restarted.
    //         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
    //             .copyWith(background: Colors.amber)),
    //     home: OnBoardingPage());
  }
}
