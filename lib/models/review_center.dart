class ReviewCenter {
  String title;
  String instructor;
  String ratingNum;
  String stars;
  String ratingCount;
  String price;
  String originalPrice;
  String isBestSeller;
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
  List<String> whatYouWillCover;
  Map<String, dynamic> programOverview;
  List<String> centerOffers;
  List<String> whoThisIsFor;
  Map<String, String> aboutThisCenter;

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
    this.subtitle = '',
    this.description = '',
    this.managedBy = '',
    this.modalities = '',
    this.location = '',
    this.website = '',
    this.phone = '',
    this.email = '',
    this.exams = '',
    this.whatYouWillCover = const [],
    this.programOverview = const {},
    this.centerOffers = const [],
    this.whoThisIsFor = const [],
    this.aboutThisCenter = const {},
  });
}
