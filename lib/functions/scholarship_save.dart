import 'package:hakbang/features/scholarship/scholarship_model.dart';
import 'package:hakbang/notifiers.dart';

class ScholarshipSave {
  static void saveScholarship(ScholarshipModel addedScholar) async {
    final updated = List<dynamic>.from(savedScholarships.value);
    final alreadySaved = updated.any(
      (scholar) => scholar.id == addedScholar.id,
    );

    if (!alreadySaved) {
      updated.add(addedScholar.id);
      savedScholarships.value = updated;
    }
  }

  static void removeScholarship(ScholarshipModel remove) async {
    final update = List<ScholarshipModel>.from(savedScholarships.value)
      ..removeWhere((element) => element.id == remove.id);

    savedScholarships.value = update;
  }
}
