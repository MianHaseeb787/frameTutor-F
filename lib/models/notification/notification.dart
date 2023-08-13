class NotificationModel {
  final String username;
  final String content;
  final DateTime timestamp;

  NotificationModel(
      {required this.content, required this.timestamp, required this.username});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      username: json['username'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
