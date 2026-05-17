import 'package:hakbang/features/scholarship/scholarship_model.dart';
import 'package:hakbang/notifiers.dart';

class ScholarshipSave {
  static void saveScholarship(ScholarshipModel addedScholar) async {
    final updated = List<ScholarshipModel>.from(savedScholarships.value);
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
  }

  static void removeScholarship(ScholarshipModel remove) async {
    final update = List<ScholarshipModel>.from(savedScholarships.value)
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
  }

  static void convertSavedScholarship() {
    final List<ScholarshipModel> scholarList = [];
    for (Map<String, dynamic> dataObjs in rawSavedScholarships.value) {
      for (ScholarshipModel scholars in availableScholarships.value) {
        if (dataObjs["scholarship_name"] == scholars.scholarshipName) {
          scholarList.add(scholars);
        }
      }
    }
    savedScholarships.value = scholarList;
  }
}
