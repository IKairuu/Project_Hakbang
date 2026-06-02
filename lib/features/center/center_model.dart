class CenterModel {
  String id;
  String title;
  String instructor;
  double ratingNum;
  int ratingCount;
  double currentPrice;
  double? lastPrice;
  String emoji;
  String subtitle;
  String description;
  String managedBy;
  String? modalities;
  String location;
  String website;
  String phone;
  String email;
  List<dynamic> exams;
  List<dynamic> coverage;
  Map<String, dynamic> programOverview;
  List<dynamic> centerOffers;
  List<dynamic> beneficiaries;
  Map<String, dynamic> aboutThisCenter;

  CenterModel({
    required this.id,
    required this.title,
    required this.instructor,
    required this.ratingNum,
    required this.ratingCount,
    required this.currentPrice,
    this.lastPrice,
    required this.emoji,
    required this.subtitle,
    required this.description,
    required this.managedBy,
    this.modalities,
    required this.location,
    required this.website,
    required this.phone,
    required this.email,
    required this.exams,
    required this.coverage,
    required this.programOverview,
    required this.centerOffers,
    required this.beneficiaries,
    required this.aboutThisCenter,
  });
}
