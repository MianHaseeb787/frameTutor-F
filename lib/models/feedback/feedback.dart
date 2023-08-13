class Feedback {
  final String? id;

  final String? username;
  final String? comment;
  final int? rating;
  final DateTime? createdAt;

  Feedback({
    this.id,
    this.username,
    this.comment,
    this.rating,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'comment': comment,
      'rating': rating,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json['_id'],
      username: json['username'],
      comment: json['comment'],
      rating: json['rating'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
