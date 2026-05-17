import 'package:hakbang/features/scholarship/scholarship_datasource.dart';
import 'package:hakbang/features/scholarship/scholarship_model.dart';
import 'package:hakbang/notifiers.dart';

class ScholarshipRepo {
  static Future<void> getScholarships() async {
    List<ScholarshipModel> scholarships = [];
    try {
      final Map<String, dynamic> data =
          await ScholarshipDatasource.getScholarshipsRouter();
      for (Map<String, dynamic> scholars in data["data"]) {
        scholarships.add(
          ScholarshipModel(
            allowance: scholars["Allowance"],
            id: scholars["ID"],
            about: scholars["about"],
            applicationSteps: scholars["application_steps"],
            applicationTimeline: scholars["application_timeline"],
            benefits: scholars["benefits"],
            deadline: scholars["deadline"],
            duration: scholars["duration"],
            eligibility: scholars["eligibility"],
            government: scholars["government"],
            grantTitle: scholars["grant_title"],
            limit: scholars["limit"],
            minGwa: (scholars["min_gwa"] ?? 0).toDouble(),
            organizationName: scholars["organizationName"],
            requiredDocuments: scholars["required_documents"],
            scholarshipName: scholars["scholarshipName"],
            scholarshipIcon: scholars["scholarship_icon"],
            color: scholars["color"],
            serviceObligation: scholars["serviceObligation"],
            tags: scholars["tags"],
            topPick: scholars["top_pick"],
            website: scholars["website"],
          ),
        );
      }
      availableScholarships.value = scholarships;
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> getSavedScholarships(String email) async {
    try {
      final List<Map<String, dynamic>> scholarList = [];
      final response = await ScholarshipDatasource.getSavedScholarshipsRouter(
        email,
      );
      for (Map<String, dynamic> dataObjs in response["data"]) {
        scholarList.add(dataObjs);
      }
      rawSavedScholarships.value = scholarList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<String> saveScholarship(String scholarName) async {
    try {
      final response = await ScholarshipDatasource.saveScholarshipRouter(
        scholarName,
      );
      return response["message"];
    } catch (error) {
      rethrow;
    }
  }

  static Future<String> removeSavedScholarship(String scholarName) async {
    try {
      final response = await ScholarshipDatasource.removeSavedScholarshipRouter(
        scholarName,
      );
      return response["message"];
    } catch (error) {
      rethrow;
    }
  }
}
