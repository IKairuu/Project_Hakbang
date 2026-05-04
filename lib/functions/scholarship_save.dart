import 'package:hakbang/models/scholarship_object.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class ScholarshipSave {
  static void saveScholarship(ScholarshipObject addedScholar) async {
    final updated = List<ScholarshipObject>.from(savedScholarships.value);
    final rawUpdated = List<Map<String, dynamic>>.from(
      rawSavedScholarships.value,
    );
    final alreadySaved = updated.any(
      (scholar) =>
          scholar.id == addedScholar.id ||
          scholar.scholarshipName == addedScholar.scholarshipName,
    );
    final rawAlreadySaved = rawUpdated.any(
      (scholar) => scholar["scholarship_name"] == addedScholar.scholarshipName,
    );

    if (!alreadySaved) {
      updated.add(addedScholar);
      savedScholarships.value = updated;
    }

    if (!rawAlreadySaved) {
      rawUpdated.add({
        "email": userCredentials.value!.email,
        "scholarship_name": addedScholar.scholarshipName,
      });
      rawSavedScholarships.value = rawUpdated;
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
    final rawUpdate =
        List<Map<String, dynamic>>.from(rawSavedScholarships.value)
          ..removeWhere(
            (element) => element["scholarship_name"] == remove.scholarshipName,
          );

    savedScholarships.value = update;
    rawSavedScholarships.value = rawUpdate;
    await Database.removeSavedScholarship(remove.scholarshipName);
  }

  static void convertSavedScholarship() {
    final List<ScholarshipObject> scholarList = [];
    for (Map<String, dynamic> dataObjs in rawSavedScholarships.value) {
      for (ScholarshipObject scholars in availableScholarships.value) {
        if (dataObjs["scholarship_name"] == scholars.scholarshipName) {
          scholarList.add(scholars);
        }
      }
    }
    savedScholarships.value = scholarList;
  }
}
