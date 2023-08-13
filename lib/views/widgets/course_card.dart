import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../consts/colors.dart';
import '../../consts/fonts.dart';
import '../../models/course/course_model.dart';

class CourseCard extends StatefulWidget {
  Course course;

  CourseCard({required this.course, super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/coursedetail', arguments: widget.course);
      },
      child: Card(
        elevation: 0,
        color: bgclr,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 239, 239, 239),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber[900],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '4.9',
                            style: paraStyleB,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.course.title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 252, 142, 45),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.course.author,
                  style: paraStyleB,
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "76.0",
              style: TextStyle(color: primaryClr, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
