import 'package:hakbang/features/college/college_datasource.dart';
import 'package:hakbang/features/college/college_model.dart';
import 'package:hakbang/functions/initialization.dart';
import 'package:hakbang/notifiers.dart';

class CollegeRepo {
  static Future<void> getCollege() async {
    try {
      Map<String, dynamic> data = await CollegeDatasource.getCollegeRouter();
      List<CollegeModel> collegeList = [];
      for (Map<String, dynamic> colleges in data["data"]) {
        collegeList.add(
          CollegeModel(
            id: colleges["ID"],
            address: colleges["address"],
            collegeName: colleges["college_name"],
            email: colleges["email"],
            fbPage: colleges["fb_page"],
            telephone: colleges["telephone"],
            type: colleges["type"],
            latitude: colleges["latitude"],
            longitude: colleges["longitude"],
            logoLink: colleges["logo_link"],
            programs: colleges["program_offered"],
            tags: colleges["tags"],
            collegeImage: colleges["college_image"],
            rating: colleges["rating"],
            programNumbers: colleges["program_numbers"],
            about: colleges["about"],
            ranking: colleges["ranking"],
          ),
        );
      }
      availableColleges.value = collegeList;
      collegeSection.value = availableColleges.value;
      Initialization.refreshCollegeSelection();
    } catch (error) {
      throw error.toString();
    }
  }
}
