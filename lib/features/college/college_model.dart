class CollegeModel {
  String id;
  String address;
  String collegeName;
  String email;
  String fbPage;
  String telephone;
  String type;
  double latitude;
  double longitude;
  String logoLink;
  List<dynamic> programs;
  List<dynamic> tags;
  String collegeImage;
  double rating;
  int programNumbers;
  String about;
  int ranking;

  CollegeModel({
    required this.id,
    required this.address,
    required this.collegeName,
    required this.email,
    required this.fbPage,
    required this.telephone,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.logoLink,
    required this.programs,
    required this.tags,
    required this.collegeImage,
    required this.rating,
    required this.programNumbers,
    required this.about,
    required this.ranking,
  });
}
