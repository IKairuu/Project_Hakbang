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
            allowance: scholars["allowance"],
            id: scholars["id"],
            about: scholars["about"],
            applicationSteps: scholars["application_steps"],
            applicationTimeline: scholars["application_timeline"],
            benefits: scholars["benefits"],
            duration: scholars["duration"],
            eligibility: scholars["eligibility"],
            startTime: scholars["start_time"],
            endTime: scholars["end_time"],
            government: scholars["government"],
            grantTitle: scholars["grant_title"],
            minGwa: scholars["min_gwa"],
            organizationName: scholars["organization_name"],
            requiredDocuments: scholars["required_documents"],
            scholarshipName: scholars["scholarship_name"],
            scholarshipIcon: scholars["scholarship_icon"],
            color: scholars["color"],
            serviceObligation: scholars["service_obligation"],
            tags: scholars["tags"],
            likes: scholars["likes"],
            website: scholars["website"],
          ),
        );
      }
      availableScholarships.value = scholarships;
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> getSavedScholarships() async {
    try {
      final List<Map<String, dynamic>> scholarList = [];
      final response = await ScholarshipDatasource.getSavedScholarshipsRouter();
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
