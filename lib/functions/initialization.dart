import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';

class Initialization {
  static void mainInitialization() async {
    await Database.getCollege();
    await Database.getScholarships();

    print(availableScholarships.value);
    collegeSection.value = availableColleges.value;
    refreshCollegeSelection();
  }

  static void refreshCollegeSelection() {
    selectedSchoolHover.value = [];
    for (var element in collegeSection.value) {
      selectedSchoolHover.value.add(false);
    }
  }
}
