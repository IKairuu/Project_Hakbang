class ScholarshipModel {
  String allowance;
  String id;
  String about;
  String color;
  List<dynamic> applicationSteps;
  List<dynamic> applicationTimeline;
  List<dynamic> benefits;
  DateTime? startTime;
  DateTime? endTime;
  int? duration;
  List<dynamic> eligibility;
  bool government;
  Map<String, dynamic>? grantTitle;
  double? minGwa;
  Map<String, dynamic> organizationName;
  List<dynamic> requiredDocuments;
  String scholarshipName;
  String scholarshipIcon;
  Map<String, dynamic>? serviceObligation;
  List<dynamic> tags;
  int likes;
  String website;

  ScholarshipModel({
    required this.allowance,
    required this.id,
    required this.about,
    required this.color,
    required this.applicationSteps,
    required this.applicationTimeline,
    required this.benefits,
    this.startTime,
    this.endTime,
    this.duration,
    required this.eligibility,
    required this.government,
    this.grantTitle,
    this.minGwa,
    required this.organizationName,
    required this.requiredDocuments,
    required this.scholarshipName,
    required this.scholarshipIcon,
    this.serviceObligation,
    required this.tags,
    required this.likes,
    required this.website,
  });
}
