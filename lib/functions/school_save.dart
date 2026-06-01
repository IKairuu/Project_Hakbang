import 'package:hakbang/features/college/college_model.dart';
import 'package:hakbang/notifiers.dart';

class SchoolSave {
  static void saveSchool(CollegeModel addedCollege) async {
    final updated = List<dynamic>.from(savedSchools.value);
    final alreadySaved = updated.any((school) => school.id == addedCollege.id);

    if (!alreadySaved) {
      updated.add(addedCollege.id);
      savedSchools.value = updated;
    }
  }

  static void removeSchool(CollegeModel removeCollege) async {
    final updated = List<dynamic>.from(savedSchools.value)
      ..removeWhere((school) => school.id == removeCollege.id);

    savedSchools.value = updated;
  }
}
