import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class SchoolSave {
  static void saveSchool(College addedCollege) async {
    final updated = List<College>.from(savedSchools.value);
    final rawUpdated = List<Map<String, dynamic>>.from(rawSavedSchools.value);
    final alreadySaved = updated.any(
      (school) =>
          school.id == addedCollege.id ||
          school.collegeName == addedCollege.collegeName,
    );
    final rawAlreadySaved = rawUpdated.any(
      (school) => school["college_name"] == addedCollege.collegeName,
    );

    if (!alreadySaved) {
      updated.add(addedCollege);
      savedSchools.value = updated;
    }

    if (!rawAlreadySaved) {
      rawUpdated.add({
        "email": userCredentials.value!.email,
        "college_name": addedCollege.collegeName,
      });
      rawSavedSchools.value = rawUpdated;
    }

    await Database.saveSchool(addedCollege.collegeName);
  }

  static void removeSchool(College removeCollege) async {
    final updated = List<College>.from(savedSchools.value)
      ..removeWhere(
        (school) =>
            school.id == removeCollege.id ||
            school.collegeName == removeCollege.collegeName,
      );
    final rawUpdated = List<Map<String, dynamic>>.from(rawSavedSchools.value)
      ..removeWhere(
        (school) => school["college_name"] == removeCollege.collegeName,
      );
    savedSchools.value = updated;
    rawSavedSchools.value = rawUpdated;

    await Database.removeSavedSchool(removeCollege.collegeName);
  }

  static void convertSavedSchools() {
    final List<College> collegeList = [];
    for (Map<String, dynamic> collegeNames in rawSavedSchools.value) {
      for (College college in availableColleges.value) {
        if (college.collegeName == collegeNames["college_name"]) {
          collegeList.add(college);
        }
      }
    }
    savedSchools.value = collegeList;
  }
}
