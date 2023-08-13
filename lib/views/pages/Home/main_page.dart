// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:frametutor/consts/colors.dart';
// import 'package:frametutor/consts/fonts.dart';
// import 'package:frametutor/views/widgets/course_card.dart';

// import '../../../controllers/course/course_controller.dart';
// import '../../../models/course/course_model.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   final CourseController _courseController = CourseController();
//   List<Course> _courses = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchCourses();
//   }

//   Future<void> _fetchCourses() async {
//     try {
//       List<Course> courses = await _courseController.getAllCourses();
//       setState(() {
//         _courses = courses;
//       });
//     } catch (e) {
//       // Handle errors if necessary
//       print('Failed to fetch courses: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Icon(
//               Icons.menu,
//               color: Colors.white,
//               size: 30,
//             ),
//           )
//         ],
//         automaticallyImplyLeading: false,
//         backgroundColor: primaryClr,
//         title: Text(
//           'Frame Tutor',
//           style: titleStyle,
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Courses',
//               style: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(
//                 _courses.length,
//                 (index) => SizedBox(
//                   width: 400, // Set a specific width for the CourseCard
//                   child: CourseCard(course: _courses[index]),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
