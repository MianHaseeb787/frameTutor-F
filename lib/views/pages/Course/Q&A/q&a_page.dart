// import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frametutor/views/pages/Course/Flashcards/flashcard_page.dart';
import 'package:frametutor/views/pages/Course/Mcqs/mcqs_page.dart';

import '../../../../consts/colors.dart';
import '../../../../consts/fonts.dart';
// import '../../../../controllers/course/course_controller.dart';
import '../../../../models/course/course_model.dart';
import '../../../../models/user/user_model.dart';
import '../../notification/notification_page.dart';

class QAScreen extends StatefulWidget {
  final Course course;
  final User user;
  const QAScreen({required this.course, required this.user});

  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // final course = _courses[2];
    // print(course.title);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 141, 124, 252),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // flex: 2,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  // height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromARGB(255, 94, 65, 255),
                        Color.fromARGB(255, 141, 124, 252)
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: primaryClr,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.amber,
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/images/Logo.png',
                                fit: BoxFit.cover),
                          ),
                          Text(
                            'Hi ${widget.user.username},',
                            style: titleStyle,
                          ),
                          Text(
                            'lets Start Learning',
                            style: paraStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Builder(builder: (context) {
                          //   return GestureDetector(
                          //     onTap: () {
                          //       Scaffold.of(context).openEndDrawer();
                          //     },
                          //     child: Icon(
                          //       Icons.menu,
                          //       color: Colors.white,
                          //       size: 30,
                          //     ),
                          //   );
                          // }),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color.fromARGB(73, 0, 0, 0)),
                                child: SvgPicture.asset(
                                  'assets/images/Notification.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BottomNavigationBar(
                elevation: 0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),

                fixedColor: primaryClr,
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                type: BottomNavigationBarType.fixed, // Set the type to fixed
                selectedLabelStyle: paraStyleBB,

                unselectedLabelStyle:
                    paraStyleB, // Remove space for unselected labels
                items: [
                  BottomNavigationBarItem(
                    // activeIcon: Image.asset(''),
                    icon: SvgPicture.asset(''),
                    label: 'Mcqs',

                    // backgroundColor: primaryC
                  ),
                  BottomNavigationBarItem(
                    // activeIcon: Image.asset('assets/images/activehome.png'),
                    icon: SvgPicture.asset(''),
                    label: 'Flashcards',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Image.asset('assets/images/Profile.png'),
                  //   label: '',
                  // ),
                ],
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    MCQScreen(
                      course: widget.course,
                      mcqsScore: widget.course.mcqScore!,
                      user: widget.user,
                    ),
                    FlashCardsScreen(
                      course: widget.course,
                      user: widget.user,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
