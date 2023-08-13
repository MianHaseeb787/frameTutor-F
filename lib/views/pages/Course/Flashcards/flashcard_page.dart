import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/consts/fonts.dart';
import 'package:frametutor/controllers/user/user_controller.dart';
// import 'package:frametutor/consts/fonts.dart';

import '../../../../models/course/course_model.dart';
import '../../../../models/user/user_model.dart';

class FlashCardsScreen extends StatefulWidget {
  final Course course;
  final User user;
  FlashCardsScreen({required this.course, required this.user});
  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  final _userController = UserController();

  void updateflashcard(int index, bool isM) {
    setState(() {
      widget.course.flashCards![index].isMastered = isM;
    });
    _userController.updateFlashcardMastered(isM, index, widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: widget.course.flashCards?.length,
              options: CarouselOptions(
                clipBehavior: Clip.none,
                height: MediaQuery.of(context).size.height * 0.4,
                initialPage: 0,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, index, realIndex) {
                final flashCard = widget.course.flashCards![index];
                return Column(
                  children: [
                    Expanded(child: FlashCardWidget(flashCard: flashCard)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: widget.course.flashCards![index].isMastered,
                          onChanged: (newValue) {
                            updateflashcard(index, newValue!);
                            // setState(() {
                            //   // print(index);
                            //   // for (var card in flashCards) {
                            //   // widget.course.flashCards![index].isMastered =
                            //   //     newValue ?? false;
                            // });
                          },
                        ),
                        Text('Mastered'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class FlashCard {
//   final FlashCard flashCard;

//   FlashCard(
//       {required this.flashCard});
// }

class FlashCardWidget extends StatefulWidget {
  final FlashCard flashCard;

  FlashCardWidget({required this.flashCard});

  @override
  _FlashCardWidgetState createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  bool _showQuestion = true;

  final _controller = FlipController();

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipWidget(
      flipDirection: FlipDirection.horizontal,
      clickable: true,
      controller: _controller,
      flipDuration: Duration(milliseconds: 1000),
      front: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 94, 65, 255),
                Color.fromARGB(255, 141, 124, 252)
              ],
            ),
            color: primaryClr,
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Text(widget.flashCard.question!,
              textAlign: TextAlign.center, style: title18W),
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 94, 65, 255),
                Color.fromARGB(255, 141, 124, 252)
              ],
            ),
            color: primaryClr,
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Text(widget.flashCard.answer!,
              textAlign: TextAlign.center, style: title18W),
        ),
      ),
    );
  }
}
