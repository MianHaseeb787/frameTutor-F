import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frametutor/consts/colors.dart';
// import 'package:frametutor/consts/colors.dart';
// import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/controllers/course/course_controller.dart';
// import 'package:frametutor/views/pages/Course/Flashcards/flashcard_page.dart';
// import 'package:frametutor/views/pages/Course/Mcqs/mcqs_page.dart';
import 'package:frametutor/views/pages/Course/Q&A/q&a_page.dart';
import 'package:frametutor/views/pages/Course/coursedetails_page.dart';
// import 'package:frametutor/views/pages/Home/main_page.dart';
import 'package:frametutor/views/pages/Profile/userprofile_page.dart';
import 'package:frametutor/views/pages/messages/messages_page.dart';
// import 'package:frametutor/views/widgets/course_card.dart';

import '../../../models/course/course_model.dart';
import '../../../models/user/user_model.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({required this.user, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final _courseController = CourseController();
  // final Course course;
  // late List<Course> _courses = [];
  @override
  void initState() {
    super.initState();
    // _fetchCourses();
    // _fetchEnrolledCourse();
  }

  // Future<void> _fetchEnrolledCourse() async {
  //   try {
  //     Course crs = await _courseController.getCourseById();

  //     setState(() {
  //       course = crs;
  //     });

  //     // _courseController
  //   } catch (e) {
  //     // Handle errors if necessary
  //     print('Failed to fetch courses: $e');
  //   }
  // }

  // Future<void> _fetchCourses() async {
  //   try {
  //     List<Course> courses = await _courseController.getAllCourses();
  //     setState(() {
  //       _courses = courses;
  //       print(_courses[0].title);
  //     });
  //   } catch (e) {
  //     // Handle errors if necessary
  //     print('Failed to fetch courses: $e');
  //   }
  // }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // final course = _courses[2];
    // print(course.title);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              CourseDetailScreen(
                course: widget.user.enrolledCourse!,
                user: widget.user,
              ),
              QAScreen(
                course: widget.user.enrolledCourse!,
                user: widget.user,
              ),
              MessagesScreen(
                user: widget.user,
              )
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Container(
                // padding: EdgeInsets.symmetric(vertical: 5),
                // height:
                child: BottomNavigationBar(
              backgroundColor: Color.fromARGB(255, 236, 236, 236),
              fixedColor: Colors.amber,
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(height: 0),
              unselectedLabelStyle: TextStyle(height: 0),
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/homef.svg',
                    color: primaryClr,
                    width: 30,
                    height: 30,
                  ),
                  icon: Image.asset(
                    'assets/images/home.png',
                    color: primaryClr,
                    width: 30,
                    height: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    'assets/images/coursef.svg',
                    color: primaryClr,
                    width: 30,
                    height: 30,
                  ),
                  icon: SvgPicture.asset(
                    'assets/images/coursel.svg',
                    color: primaryClr,
                    width: 30,
                    height: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/chat.svg',
                    width: 30,
                    height: 30,
                    color: primaryClr,
                  ),
                  label: '',
                ),
              ],
            )),
          )),
    );
  }
}

// ListTile(
//      Color.fromARGB(255, 180, 172, 167)course.title),
//           subtitle: Text(course.author),
//           onTap: () {
//             // Handle tap on the course card (navigate to course details, for example)
//           },
//         )
