import 'package:flutter/material.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/controllers/user/user_controller.dart';

import '../../../../models/course/course_model.dart';
import '../../../../models/user/user_model.dart';

class MCQScreen extends StatefulWidget {
  final Course course;
  int mcqsScore;
  final User user;

  MCQScreen(
      {required this.course, required this.mcqsScore, required this.user});

  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  UserController _userController = UserController();
  int marks = 0;

  late String userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('inint');
    for (final question in widget.course.multipleChoiceQuestions!) {
      question.selectedOption = -1;
    }
    marks = 0;
  }

  void updateScore() {
    _userController.updateMcqsScore(marks, widget.user.id);
    for (final question in widget.course.multipleChoiceQuestions!) {
      question.selectedOption = -1;
    }
    // marks = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryClr,
          title: Text(
            'Score Submitted',
            style: appBartitleStyle,
          ),
          content: Row(
            children: [
              Text(
                'Your score is: ',
                style: paraStyle,
              ),
              Text(
                ' $marks',
                style: appBartitleStyle,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Try Again',
                style: paraStyle,
              ),
              onPressed: () {
                // for (final question in widget.course.multipleChoiceQuestions!) {
                //   question.selectedOption = -1;
                // }
                Navigator.of(context).pop();
                marks = 0;
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print(marks);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.course.multipleChoiceQuestions?.length,
        itemBuilder: (context, index) {
          final question = widget.course.multipleChoiceQuestions![index];
          final isCorrect = question.selectedOption == question.correctOption;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      question.options!.length,
                      (optionIndex) {
                        final option = question.options![optionIndex];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (question.selectedOption == -1) {
                                question.selectedOption = optionIndex;
                                if (question.selectedOption ==
                                    question.correctOption) {
                                  marks++;
                                  print(marks);
                                }
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Visibility(
                                    visible: question.selectedOption ==
                                            optionIndex &&
                                        isCorrect,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Visibility(
                                    visible: question.selectedOption ==
                                            optionIndex &&
                                        !isCorrect,
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        question.selectedOption != optionIndex,
                                    child: Icon(
                                      Icons.radio_button_unchecked,
                                      color: Color.fromARGB(0, 158, 158, 158),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: paraStyleB,
                                      // maxLines: 2,
                                      // softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          updateScore();
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 94, 65, 255),
                Color.fromARGB(255, 141, 124, 252)
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            // shape: BoxShape.rectangle,
            color: primaryClr,
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('submit', style: btn16W),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check,
                color: Colors.white,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
