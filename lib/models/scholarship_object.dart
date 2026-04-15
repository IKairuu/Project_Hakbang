class ScholarshipObject {
  String title;
  String subtitle;
  List<dynamic> tags;
  String scholarIcon;
  String description;
  List<dynamic> details;
  String website;
  int limit;
  int slots;

  ScholarshipObject({
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.scholarIcon,
    required this.description,
    required this.details,
    required this.website,
    required this.limit,
    required this.slots,
  });
}
