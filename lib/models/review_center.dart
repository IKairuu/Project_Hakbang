class ReviewCenter {
  String title;
  String instructor;
  String ratingNum;
  String stars;
  String ratingCount;
  String price;
  String originalPrice;
  bool isBestSeller;
  String emoji;
  String subtitle;
  String description;
  String managedBy;
  String modalities;
  String location;
  String website;
  String phone;
  String email;
  String exams;
  List<dynamic> coverage;
  Map<String, dynamic> programOverview;
  List<dynamic> centerOffers;
  List<dynamic> whoThisIsFor;
  Map<String, dynamic> aboutThisCenter;

  ReviewCenter({
    required this.title,
    required this.instructor,
    required this.ratingNum,
    required this.stars,
    required this.ratingCount,
    required this.price,
    required this.originalPrice,
    required this.isBestSeller,
    required this.emoji,
    required this.subtitle,
    required this.description,
    required this.managedBy,
    required this.modalities,
    required this.location,
    required this.website,
    required this.phone,
    required this.email,
    required this.exams,
    required this.coverage,
    required this.programOverview,
    required this.centerOffers,
    required this.whoThisIsFor,
    required this.aboutThisCenter,
  });
}
