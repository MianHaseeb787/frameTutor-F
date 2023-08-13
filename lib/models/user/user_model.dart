import 'package:frametutor/models/course/course_model.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String
      password; // Note: Insecure, consider using encryption/secure storage in production
  Course? enrolledCourse;
  List<Progress>? progress;
  LastWatchedVideo lastWatchedVideo;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    this.enrolledCourse,
    this.progress,
    required this.lastWatchedVideo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // List<String>? enrolledCourses =
    //     List<String>.from(json['enrolledCourses'] ?? []);
    List<Progress>? progress = [];
    for (var progressItem in json['progress'] ?? []) {
      progress.add(Progress.fromJson(progressItem));
    }

    return User(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      enrolledCourse: Course.fromJson(json['enrolledCourse']),
      progress: progress,
      lastWatchedVideo:
          LastWatchedVideo.fromJson(json['lastWatchedVideo'] ?? {}),
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }
}

class Progress {
  final String course;
  final String section;
  final String lesson;
  final bool completed;

  Progress({
    required this.course,
    required this.section,
    required this.lesson,
    required this.completed,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      course: json['course'] ?? '',
      section: json['section'] ?? '',
      lesson: json['lesson'] ?? '',
      completed: json['completed'] ?? false,
    );
  }
}

class LastWatchedVideo {
  final String course;
  final String videoId;
  final int timestamp;

  LastWatchedVideo({
    required this.course,
    required this.videoId,
    required this.timestamp,
  });

  factory LastWatchedVideo.fromJson(Map<String, dynamic> json) {
    return LastWatchedVideo(
      course: json['course'] ?? '',
      videoId: json['videoId'] ?? '',
      timestamp: json['timestamp'] ?? 0,
    );
  }
}
