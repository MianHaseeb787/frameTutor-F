import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frametutor/consts/colors.dart';
import 'package:frametutor/views/pages/Home/Navbar_page.dart';
import 'package:frametutor/views/pages/login/login_page.dart';
import 'package:frametutor/views/pages/signup/signup_page.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  bool _completedOnboarding = false; // Add this variable

  void _onIntroEnd(context) {
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (_) => HomeScreen(user: ,)),
    // );
    setState(() {
      _completedOnboarding = true;
    });
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          // infiniteAutoScroll: true,
          // globalHeader: Align(
          //   alignment: Alignment.topRight,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 16, right: 16),
          //       child: _buildImage('flutter.png', 100),
          //     ),
          //   ),
          // ),
          // globalFooter: SizedBox(
          //   width: double.infinity,
          //   height: 60,
          //   child: ElevatedButton(
          //     child: const Text(
          //       'Let\'s go right away!',
          //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //     ),
          //     onPressed: () => _onIntroEnd(context),
          //   ),
          // ),
          pages: [
            PageViewModel(
              title: "Beginners \nPhotography Course",
              body:
                  "Complete the full course with full dedication to get certificate",
              image: Image.asset('assets/images/onboard1.png'),
              decoration: pageDecoration.copyWith(
                // titlePadding: ,
                bodyAlignment: Alignment.topLeft,

                // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                // fullScreen: true,
                bodyFlex: 1,
                imageFlex: 2,
                safeArea: 100,
              ),
            ),
            PageViewModel(
              title: "Beginners \nPhotography Course",
              body:
                  "Complete the full course with full dedication to get certificate",
              image: Image.asset('assets/images/onboard1.png'),
              decoration: pageDecoration.copyWith(
                // titlePadding: ,
                bodyAlignment: Alignment.topLeft,

                // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                // fullScreen: true,
                bodyFlex: 1,
                imageFlex: 2,
                safeArea: 100,
              ),
            ),
            // PageViewModel(
            //   title: "Full Screen Page",
            //   body:
            //       "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
            //   image: _buildFullscreenImage(),
            //   decoration: pageDecoration.copyWith(
            //     contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            //     fullScreen: true,
            //     bodyFlex: 2,
            //     imageFlex: 3,
            //     safeArea: 100,
            //   ),
            // ),
            PageViewModel(
              title: "Beginners \nPhotography Course",
              body:
                  "Complete the full course with full dedication to get certificate",
              image: Image.asset('assets/images/onboard1.png'),
              decoration: pageDecoration.copyWith(
                // titlePadding: ,
                bodyAlignment: Alignment.topLeft,

                // contentMargin: const EdgeInsets.symmetric(horizontal: 16),
                // fullScreen: true,
                bodyFlex: 1,
                imageFlex: 2,
                safeArea: 50,
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // showSkipButton: true,
          skipOrBackFlex: 0,
          // showNextButton: true,
          // showBottomPart: false,
          nextFlex: 1,
          dotsFlex: 1,
          showBackButton: false,
          //rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_back),
          skip:
              const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
          next: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: const Text('Next',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryClr)),
          ),
          done: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('onboard', true);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(100, 50),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              backgroundColor: primaryClr,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child:
                Text('Go', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(20),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color.fromARGB(255, 198, 198, 198),
            activeSize: Size(30.0, 10.0),
            activeColor: primaryClr,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          // dotsContainerDecorator: const ShapeDecoration(
          //   color: Color.fromARGB(0, 0, 0, 0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
          //   ),
          // ),
        ),
      ),
    );
  }
}
