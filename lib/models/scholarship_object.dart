class ScholarshipObject {
  String allowance;
  int id;
  String about;
  List<dynamic> applicationSteps;
  List<dynamic> applicationTimeline;
  List<dynamic> benefits;
  int deadline;
  int limit;
  int duration;
  List<dynamic> eligibility;
  bool government;
  Map<String, dynamic> grantTitle;
  double minGwa;
  Map<String, dynamic> organizationName;
  List<dynamic> requiredDocuments;
  String scholarshipName;
  String scholarshipIcon;
  Map<String, dynamic> serviceObligation;
  List<dynamic> tags;
  int topPick;
  String website;

  ScholarshipObject({
    required this.allowance,
    required this.id,
    required this.about,
    required this.applicationSteps,
    required this.applicationTimeline,
    required this.benefits,
    required this.deadline,
    required this.limit,
    required this.duration,
    required this.eligibility,
    required this.government,
    required this.grantTitle,
    required this.minGwa,
    required this.organizationName,
    required this.requiredDocuments,
    required this.scholarshipName,
    required this.scholarshipIcon,
    required this.serviceObligation,
    required this.tags,
    required this.topPick,
    required this.website,
  });
}
