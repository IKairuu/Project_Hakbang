import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class SchoolSave {
  static void saveSchool(College addedCollege) async {
    savedSchools.value.add(addedCollege);
    await Database.saveSchool(addedCollege.collegeName);
  }

  static void removeSchool(College removeCollege) async {
    savedSchools.value.remove(removeCollege);
    await Database.removeSavedSchool(removeCollege.collegeName);
  }
}
