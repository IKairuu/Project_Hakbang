import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class SchoolSave {
  static void saveSchool(College addedCollege) async {
    final updated = List<College>.from(savedSchools.value);
    final alreadySaved = updated.any(
      (school) =>
          school.id == addedCollege.id ||
          school.collegeName == addedCollege.collegeName,
    );

    if (!alreadySaved) {
      updated.add(addedCollege);
      savedSchools.value = updated;
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

    savedSchools.value = updated;

    await Database.removeSavedSchool(removeCollege.collegeName);
  }
}
