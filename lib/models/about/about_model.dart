class About {
  final String para1;
  final String para2;
  // final String img1;
  // final String img2;

  About({
    required this.para1,
    required this.para2,
    // required this.img1,
    // required this.img2,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      para1: json['para1'],
      para2: json['para2'],
      // img1: json['img1'],
      // img2: json['img2'],
    );
  }
}
