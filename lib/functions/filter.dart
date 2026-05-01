import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/models/review_center.dart';
import 'package:hakbang/models/scholarship_object.dart';
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
    Initialization.refreshCollegeSelection();
  }

  static void searchCollege(String input) {
    collegeSection.value = [];
    for (var colleges in availableColleges.value) {
      for (String key in input.toLowerCase().split(" ")) {
        if (selectedFilter.value[0]) {
          if (colleges.collegeName.toLowerCase().split(" ").contains(key) &&
              !collegeSection.value.contains(colleges)) {
            collegeSection.value.add(colleges);
            break;
          }
        } else if (selectedFilter.value[1]) {
          if (colleges.collegeName.toLowerCase().split(" ").contains(key) &&
              colleges.type == "state university") {
            collegeSection.value.add(colleges);
            break;
          }
        } else {
          if (colleges.collegeName.toLowerCase().split(" ").contains(key) &&
              colleges.type == "private") {
            collegeSection.value.add(colleges);
            break;
          }
        }
      }
    }
  }

  static void filterReviewHubs(String title) {
    Initialization.refreshReviewCenters();
    for (ReviewCenter center in availableReviewCenters.value) {
      if (title.toLowerCase() == "all") {
        reviewCenterSection.value = availableReviewCenters.value;
        break;
      } else if (center.modalities
          .toLowerCase()
          .split(" ")
          .contains(title.toLowerCase())) {
        reviewCenterSection.value.add(center);
      }
    }
  }

  static void searchReviewHubs(String input) {
    List<ReviewCenter> searchedList = [];
    for (ReviewCenter center in reviewCenterSection.value) {
      for (String word in input.toLowerCase().split(" ")) {
        if (center.title.toLowerCase().split(" ").contains(word)) {
          searchedList.add(center);
          break;
        }
      }
    }
    Initialization.refreshReviewCenters();
    reviewCenterSection.value = searchedList;
  }

  static void getTopPick() {
    featuredScholarship.value = availableScholarships.value.reduce(
      (a, b) => a.topPick > b.topPick ? a : b,
    );
  }

  static void filterScholarships() {
    governmentSection.value = [];
    nonGovernmentSection.value = [];
    for (ScholarshipObject scholar in availableScholarships.value) {
      if (scholar.government) {
        governmentSection.value.add(scholar);
      } else {
        nonGovernmentSection.value.add(scholar);
      }
    }
  }

  static void searchScholarship(String input, bool government) {
    List<ScholarshipObject> searchedList = [];
    for (ScholarshipObject objs in availableScholarships.value) {
      for (String word in input.split(" ")) {
        if (objs.scholarshipName
                .toLowerCase()
                .split(" ")
                .contains(word.toLowerCase()) &&
            government == objs.government) {
          searchedList.add(objs);
          break;
        }
      }
    }

    switch (government) {
      case true:
        governmentSection.value = searchedList;
        break;
      case false:
        nonGovernmentSection.value = searchedList;
        break;
    }
  }
}
