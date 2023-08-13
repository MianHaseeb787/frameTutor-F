import 'package:flutter/material.dart';
import '../../../consts/colors.dart';
import '../../../consts/fonts.dart';
import '../../../controllers/feedback/feedback_controller.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final FeedbackController _feedbackController = FeedbackController();
  TextEditingController _commentController = TextEditingController();

  int rating = 0;

  void _submitFeedback() async {
    if (rating > 0) {
      try {
        await FeedbackController.sendFeedback(
          'Asfand', // Replace with the actual username
          _commentController.text,
          rating,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully')),
        );

        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit feedback. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Please select a rating before submitting feedback.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Feedback',
          style: appBartitleStyleB,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate your Experience',
                  style: titleStyleB,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We'd love to hear from you",
                  style: paraStyleB,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: List.generate(5, (index) {
                    bool isSelected = index < rating;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                      child: Icon(
                        isSelected ? Icons.star : Icons.star_border_outlined,
                        size: 40,
                        color: primaryClr,
                      ),
                    );
                  }),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us what can be improved',
                  style: paraStyleBB,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    OutlineRoundedButton(
                      onPressed: () {
                        print('Button tapped!');
                        _commentController.text = 'Overal service';
                      },
                      text: 'Overal service',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlineRoundedButton(
                      onPressed: () {
                        _commentController.text = 'support';
                        print('Button tapped!');
                      },
                      text: 'support',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    OutlineRoundedButton(
                      onPressed: () {
                        // Handle button tap
                        print('Button tapped!');
                        _commentController.text = 'speed & efficiency';
                      },
                      text: 'speed & efficiency',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlineRoundedButton(
                      onPressed: () {
                        // Handle button tap
                        print('Button tapped!');
                        _commentController.text = 'organizing';
                      },
                      text: 'organizing',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _commentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Tell us how can we improve',
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  _submitFeedback();
                } else {
                  final snackBar =
                      SnackBar(content: Text('Please add your comment'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text(
                'Send',
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
    );
  }
}

class OutlineRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  OutlineRoundedButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Color.fromARGB(255, 94, 93, 95),
            width: 1.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 94, 93, 95)),
        ),
      ),
    );
  }
}
