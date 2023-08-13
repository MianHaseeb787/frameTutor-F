import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frametutor/controllers/user/user_controller.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../consts/colors.dart';
import '../../../../consts/fonts.dart';
import '../../../../models/course/course_model.dart';
import '../../../../models/user/user_model.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class VideoScreen extends StatefulWidget {
  final Course course;
  final User user;

  const VideoScreen({required this.course, required this.user});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final _userController = UserController();
  late BetterPlayerController _controller;
  // late RxBool isVideoCompleted;
  late String selectedUrl;

  List<Duration> _videoDurations = [];
  late List<String> videoUrls = [];

  fetchVideoUrls() async {
    for (int i = 0; i < widget.course.videos!.length; i++) {
      videoUrls.add(widget.course.videos![i].videoUrl!);
    }
    _initializeVideoDurations();
  }

  void _initializeVideoDurations() async {
    for (String url in videoUrls) {
      final dataSource = BetterPlayerDataSource.network(url);
      final betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: dataSource,
      );
      await betterPlayerController.setupDataSource(dataSource);
      final duration =
          betterPlayerController.videoPlayerController!.value.duration;

      setState(() {
        _videoDurations.add(duration!);
      });

      betterPlayerController.dispose();
    }
  }

  void fetchCompletedStatus() async {
    for (int i = 0; i < widget.user.enrolledCourse!.videos!.length; i++) {
      bool isVideoComplete =
          await _userController.fetchVideoCompletedStatus(widget.user.id, i);

      print(isVideoComplete);
      setState(() {
        widget.user.enrolledCourse!.videos![i].completed = isVideoComplete;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVideoUrls();
    // _initializeVideoDurations();
    print('inint');
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // isVideoCompleted = false.obs;
    // isVideoCompleted.value = widget.user.enrolledCourse!.videos![0].completed!;

    // print(widget.user.enrolledCourse!.videos![0].completed);
    // print(isVideoCompleted.value);

    _controller = BetterPlayerController(
      BetterPlayerConfiguration(),
      betterPlayerDataSource: BetterPlayerDataSource.network(videoUrls[0]),
    );

    fetchCompletedStatus();
    // if(widget.course.videos![0].videoUrl!.isNotEmpty){

    // }

    _playVideo(widget.course.videos![0].videoUrl!, 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    print('dispose');
    super.dispose();
  }

  void _playVideo(String url, int index) async {
    final currentWatchTime =
        await _userController.fetchWatchTimeFromServer(widget.user.id, index);

    // Create a new BetterPlayerController instance
    BetterPlayerController newController = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: false,
        startAt: Duration(seconds: currentWatchTime),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(url),
    );

    // Add event listeners to the new controller
    newController.addEventsListener((event) async {
      // if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
      //   // Set portrait orientation when exiting full screen
      //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // }
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        final progress = event.parameters!['progress'] as Duration;
        final currentPosition = progress.inSeconds;
        final updatedWatchTime = currentWatchTime + currentPosition;

        _userController.updateWatchTimeInDatabase(
            index, widget.user.id, updatedWatchTime);
      }

      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        const completedd = true;

        _userController.updateCompletedInDatabase(
            index, widget.user.id, completedd);

        setState(() {
          widget.user.enrolledCourse!.videos![index].completed = completedd;
          newController.exitFullScreen();
        });

        _userController.updateWatchTimeInDatabase(index, widget.user.id, 0);

        // Dispose the new controller when playback finishes

        Future.delayed(Duration(seconds: 2));
        newController.dispose();

        if (index + 1 < widget.course.videos!.length) {
          final nextVideoUrl = widget.course.videos![index + 1].videoUrl!;
          _playVideo(nextVideoUrl, index + 1);
        }
      }
    });

    // Dispose the previous controller and assign the new controller
    if (_controller != null) {
      _controller.dispose();
    }
    setState(() {
      _controller = newController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: BetterPlayer(controller: _controller),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgclr,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 252, 142, 45),
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.course.author,
                              style: paraStyleB,
                            ),
                          ],
                        ),
                        Text(
                          widget.course.title,
                          style: paraStyleB,
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.course.videos?.length,
                            itemBuilder: (context, index) {
                              final _videos = widget.course.videos![index];
                              final isDurationAvailable =
                                  _videoDurations.isNotEmpty &&
                                      index < _videoDurations.length;
                              final videoDuration = isDurationAvailable
                                  ? _videoDurations[index]
                                  : Duration.zero;

                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Color.fromARGB(255, 248, 246, 255),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "0${(index + 1).toString()}",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 30,
                                        color: Color.fromARGB(
                                          255,
                                          173,
                                          172,
                                          176,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _videos.title ?? 'Video Title',
                                    style: paraStyleB,
                                  ),
                                  subtitle: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/clock.svg',
                                        width: 25,
                                        height: 25,
                                      ),
                                      SizedBox(width: 10),
                                      _videoDurations.isNotEmpty
                                          ? Text(
                                              '${videoDuration.inMinutes}:${videoDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize:
                                                      20, // Adjust the font size
                                                  fontWeight: FontWeight
                                                      .normal, // Adjust the font weight
                                                  color: Color.fromARGB(
                                                      255,
                                                      255,
                                                      135,
                                                      7) // Adjust the text color
                                                  // You can add more style properties here as needed
                                                  ),
                                            )
                                          : Text(
                                              'Loading',
                                              style: paraStyleB,
                                            ),
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedUrl = _videos.videoUrl!;

                                          _playVideo(selectedUrl, index);

                                          print(
                                            _videos.videoUrl!,
                                          );
                                        });
                                      },
                                      child: CircularPercentIndicator(
                                        radius: 25.0,
                                        lineWidth: 2.0,
                                        percent: widget.user.enrolledCourse!
                                                .videos![index].completed!
                                            ? 1.0
                                            : 0.1,
                                        backgroundColor: Colors.transparent,
                                        center: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: primaryClr,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        progressColor: Color.fromARGB(
                                          255,
                                          252,
                                          142,
                                          45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
