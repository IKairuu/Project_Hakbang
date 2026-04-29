class ScholarshipObject {
  String allowance;
  int id;
  String about;
  List<dynamic> applicationSteps;
  List<Map<String, dynamic>> applicationTimeline;
  List<Map<String, dynamic>> benefits;
  int deadline;
  int duration;
  List<String> eligibility;
  bool government;
  Map<String, dynamic> grantTitle;
  double minGwa;
  List<Map<String, dynamic>> organizationName;
  List<String> requiredDocuments;
  String scholarshipName;
  String scholarshipIcon;
  Map<String, dynamic> serviceObligation;
  List<String> tags;
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
