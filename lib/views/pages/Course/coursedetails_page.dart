import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frametutor/cc.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/controllers/course/course_controller.dart';
import 'package:frametutor/views/pages/Aboutus/aboutus_page.dart';
import 'package:frametutor/views/pages/Course/Ebook/ebook_page.dart';
import 'package:frametutor/views/pages/Feedback/feedback_page.dart';
import 'package:frametutor/views/pages/login/login_page.dart';
import 'package:frametutor/views/pages/notification/notification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/course/course_model.dart';
import '../../../models/user/user_model.dart';
import 'video/videos_page.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  final User user;
  CourseDetailScreen({required this.course, required this.user});
  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final _courseController = CourseController();
  // late List<Course> _courses = [];
  // late Course course;
  @override
  void initState() {
    super.initState();
    // _fetchCourses();
  }

  // Future<void> _fetchCourses() async {
  //   try {
  //     List<Course> courses = await _courseController.getAllCourses();
  //     setState(() {
  //       _courses = courses;
  //     });
  //   } catch (e) {
  //     // Handle errors if necessary
  //     print('Failed to fetch courses: $e');
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the course object from the arguments
    // final Course course = ModalRoute.of(context)!.settings.arguments as Course;
    // course = _courses[0];
    // print(course);
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(255, 94, 65, 255),
                    Color.fromARGB(255, 141, 124, 252)
                  ],
                ),
                // color: primaryClr,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${widget.user.username}',
                    style: titleStyle,
                  ),
                  Text(
                    '${widget.user.email}',
                    style: paraStyle,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.question_mark,
                color: primaryClr,
              ),
              title: const Text(
                'About us',
                style: title16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: primaryClr,
              ),
              title: const Text(
                'Feedback',
                style: title16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: primaryClr,
              ),
              title: const Text(
                'Logout',
                style: title16,
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('login', false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInScreen();
                    },
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        actions: [new Container()],
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 141, 124, 252), // Status bar color
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // flex: 1,
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
                          width: 90,
                          height: 80,
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
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationScreen()),
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

            // video container

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Videos', style: title20),
                            Expanded(
                              // flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoScreen(
                                              user: widget.user,
                                              course: widget.course)));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  width: double.infinity,
                                  // height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const AssetImage(
                                            'assets/images/photographer.png'), // Replace with your image path
                                        fit: BoxFit.cover,
                                      ),
                                      color: Color.fromARGB(255, 183, 183, 183),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors
                                                .white, // Replace with your desired icon color
                                            size:
                                                40, // Replace with your desired icon size
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(widget.course.title, style: title16),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 252, 142, 45),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.course.author,
                                  style: para16,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              // flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PDFViewerScreen(
                                                user: widget.user,
                                              )));
                                },
                                child: Container(
                                    // height: 5,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    width: double.infinity,
                                    // height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryClr, width: 2),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(255, 248, 246, 255),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            right: 50,
                                            top: 20,
                                            child: Text(
                                              'Read',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            )),
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/ebookicon.png'),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'E-Book',
                                                  style: title20,
                                                ),
                                                SizedBox(
                                                  height: 0,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "understanding ISO,",
                                                    style: para14,
                                                    softWrap: true,
                                                    maxLines: 1,

                                                    // textScaleFactor: 0.5,
                                                    // style: paraStyle,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text('Course Briefs', style: title18),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              // flex: 2,
                              child: ListView.builder(
                                  itemCount: widget.course.briefs!.length,
                                  itemBuilder: (context, index) {
                                    final brf = widget.course.briefs![index];
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        color:
                                            Color.fromARGB(255, 248, 246, 255),
                                        // Use the light blue color from the Colors class
                                        child: ExpansionTile(
                                          // collapsedTextColor: Colors.amber,
                                          textColor: primaryClr,

                                          // contentPadding: EdgeInsets.symmetric(
                                          //     vertical: 15, horizontal: 10),
                                          leading: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                255,
                                                173,
                                                172,
                                                176,
                                              ),
                                            ),
                                          ),
                                          title: Text("${brf.chapter}",
                                              style: btn16),
                                          // textColor: Colors.amber,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                              child: Text(
                                                brf.content!,
                                                style: para14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
