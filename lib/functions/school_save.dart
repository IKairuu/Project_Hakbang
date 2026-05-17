import 'package:hakbang/features/college/college_model.dart';
import 'package:hakbang/notifiers.dart';

class SchoolSave {
  static void saveSchool(CollegeModel addedCollege) async {
    final updated = List<CollegeModel>.from(savedSchools.value);
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
  }

  static void removeSchool(CollegeModel removeCollege) async {
    final updated = List<CollegeModel>.from(savedSchools.value)
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
  }

  static void convertSavedSchools() {
    final List<CollegeModel> collegeList = [];
    for (Map<String, dynamic> collegeNames in rawSavedSchools.value) {
      for (CollegeModel college in availableColleges.value) {
        if (college.collegeName == collegeNames["college_name"]) {
          collegeList.add(college);
        }
      }
    }
    savedSchools.value = collegeList;
  }
}
