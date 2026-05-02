import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class ScholarshipSave {
  static void saveScholarship(ScholarshipObject addedScholar) async {
    final updated = List<ScholarshipObject>.from(savedScholarships.value);
    final alreadySaved = updated.any(
      (scholar) =>
          scholar.id == addedScholar.id ||
          scholar.scholarshipName == addedScholar.scholarshipName,
    );

    if (!alreadySaved) {
      updated.add(addedScholar);
      savedScholarships.value = updated;
    }

    await Database.saveScholarship(addedScholar.scholarshipName);
  }

  static void removeScholarship(ScholarshipObject remove) async {
    final update = List<ScholarshipObject>.from(savedScholarships.value)
      ..removeWhere(
        (element) =>
            element.id == remove.id ||
            element.scholarshipName == remove.scholarshipName,
      );

    savedScholarships.value = update;
    await Database.removeSavedScholarship(remove.scholarshipName);
  }
}
