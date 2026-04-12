import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';

class Filter {
  static void filterCollegeSection(List<College> colleges) {
    collegeSection.value = [];
    if (selectedFilter.value[0]) {
      collegeSection.value = availableColleges.value;
    }

    if (selectedFilter.value[1]) {
      for (College data in colleges) {
        if (data.type == "state university") {
          collegeSection.value.add(data);
        }
      }
    }
    if (selectedFilter.value[2]) {
      for (College data in colleges) {
        if (data.type == "private") {
          collegeSection.value.add(data);
        }
      }
    }
  }
}
