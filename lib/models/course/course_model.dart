class Course {
  final String id;
  final String title;
  final String author;
  List<Video>? videos;
  List<Brief>? briefs;
  Ebook? ebook;
  List<FlashCard>? flashCards;
  List<MultipleChoiceQuestion>? multipleChoiceQuestions;
  final int? mcqScore;
  // List<Feedback>? feedback;
  final DateTime createdAt;
  final DateTime updatedAt;

  Course({
    required this.id,
    required this.title,
    required this.author,
    this.videos,
    this.briefs,
    this.ebook,
    this.flashCards,
    this.multipleChoiceQuestions,
    this.mcqScore,
    // this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'author': author,
      'videos': videos?.map((video) => video.toJson()).toList(),
      'briefs': briefs?.map((brief) => brief.toJson()).toList(),
      'ebook': ebook?.toJson(),
      'flashCards': flashCards?.map((flashCard) => flashCard.toJson()).toList(),
      'multipleChoiceQuestions':
          multipleChoiceQuestions?.map((mcq) => mcq.toJson()).toList(),
      'mcqScore': mcqScore,

      // 'feedback': feedback?.map((feedback) => feedback.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    List<Video>? videos;
    if (json['videos'] != null) {
      videos = List<Video>.from(
          json['videos'].map((video) => Video.fromJson(video)));
    }

    List<Brief>? briefs;
    if (json['briefs'] != null) {
      briefs = List<Brief>.from(
          json['briefs'].map((brief) => Brief.fromJson(brief)));
    }

    return Course(
      id: json['_id'],
      title: json['title'],
      author: json['author'],
      mcqScore: json['mcqScore'],
      videos: videos,
      briefs: briefs,
      ebook: json['ebook'] != null ? Ebook.fromJson(json['ebook']) : null,
      flashCards: json['flashCards'] != null
          ? List<FlashCard>.from(json['flashCards']
              .map((flashCard) => FlashCard.fromJson(flashCard)))
          : null,
      multipleChoiceQuestions: json['multipleChoiceQuestions'] != null
          ? List<MultipleChoiceQuestion>.from(json['multipleChoiceQuestions']
              .map((mcq) => MultipleChoiceQuestion.fromJson(mcq)))
          : null,
      // feedback: json['feedback'] != null
      //     ? List<Feedback>.from(
      //         json['feedback'].map((feedback) => Feedback.fromJson(feedback)))
      //     : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Video {
  final String? title;
  final String? description;
  final String? videoUrl;
  final int? totalTime;
  final int? watchTime;
  late bool? completed;
  final String? videoHandle;
  final String? thumbnailUrl;

  Video({
    this.totalTime,
    this.watchTime,
    this.completed,
    this.title,
    this.description,
    this.videoUrl,
    this.videoHandle,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'totalTime': totalTime,
      'watchTime': watchTime,
      'completed': completed,
      'videoHandle': videoHandle,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      totalTime: json['totalTime'],
      watchTime: json['watchTime'],
      completed: json['completed'],
      videoHandle: json['videoHandle'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class Brief {
  final String? chapter;
  final String? content;

  Brief({
    this.chapter,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'chapter': chapter,
      'content': content,
    };
  }

  factory Brief.fromJson(Map<String, dynamic> json) {
    return Brief(
      chapter: json['chapter'],
      content: json['content'],
    );
  }
}

class Ebook {
  final String? title;
  final String? author;
  final String? format;
  final String? url;
  final String? coverImage;
  List<Bookmark>? bookmarks;
  List<Highlight>? highlights;

  Ebook({
    this.title,
    this.author,
    this.format,
    this.url,
    this.coverImage,
    this.bookmarks,
    this.highlights,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'format': format,
      'url': url,
      'coverImage': coverImage,
      'bookmarks': bookmarks?.map((bookmark) => bookmark.toJson()).toList(),
      'highlights': highlights?.map((highlight) => highlight.toJson()).toList(),
    };
  }

  factory Ebook.fromJson(Map<String, dynamic> json) {
    List<Bookmark>? bookmarks;
    if (json['bookmarks'] != null) {
      bookmarks = List<Bookmark>.from(
          json['bookmarks'].map((bookmark) => Bookmark.fromJson(bookmark)));
    }

    List<Highlight>? highlights;
    if (json['highlights'] != null) {
      highlights = List<Highlight>.from(
          json['highlights'].map((highlight) => Highlight.fromJson(highlight)));
    }

    return Ebook(
      title: json['title'],
      author: json['author'],
      format: json['format'],
      url: json['url'],
      coverImage: json['coverImage'],
      bookmarks: bookmarks,
      highlights: highlights,
    );
  }
}

class Bookmark {
  final int? pageNumber;
  final String? label;
  final String? note;

  Bookmark({
    this.pageNumber,
    this.label,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'label': label,
      'note': note,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      pageNumber: json['pageNumber'],
      label: json['label'],
      note: json['note'],
    );
  }
}

class Highlight {
  final int? pageNumber;
  final String? content;
  final String? color;

  Highlight({
    this.pageNumber,
    this.content,
    this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      'content': content,
      'color': color,
    };
  }

  factory Highlight.fromJson(Map<String, dynamic> json) {
    return Highlight(
      pageNumber: json['pageNumber'],
      content: json['content'],
      color: json['color'],
    );
  }
}

class FlashCard {
  final String? id;
  final String? question;
  final String? answer;
  bool? isMastered;

  FlashCard({
    this.id,
    this.question,
    this.answer,
    this.isMastered,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'isMastered': isMastered,
    };
  }

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      question: json['question'],
      answer: json['answer'],
      isMastered: json['isMastered'],
    );
  }
}

class MultipleChoiceQuestion {
  final String? question;
  final List<String>? options;
  final int? correctOption;
  int? selectedOption;

  MultipleChoiceQuestion({
    this.question,
    this.options,
    this.correctOption,
    this.selectedOption,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctOption': correctOption,
      'selectedOption': selectedOption,
    };
  }

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      question: json['question'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      correctOption: json['correctOption'],
      selectedOption: json['selectedOption'],
    );
  }
}
