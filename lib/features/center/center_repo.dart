import 'package:hakbang/features/center/center_datasource.dart';
import 'package:hakbang/features/center/center_model.dart';
import 'package:hakbang/notifiers.dart';

class CenterRepo {
  static Future<void> getHubs() async {
    try {
      final response = await CenterDatasource.getHubsRouter();
      List<CenterModel> hubList = [];
      for (dynamic data in response["data"]) {
        hubList.add(
          CenterModel(
            title: data["title"],
            instructor: data["instructor"],
            ratingNum: data["rating_num"],
            stars: data["stars"],
            ratingCount: data["rating_count"],
            price: data["price"],
            originalPrice: data["original_price"],
            isBestSeller: data["is_best_seller"],
            emoji: data["emoji"],
            coverage: data["coverage"],
            programOverview: data["program_overview"],
            centerOffers: data["center_offers"],
            whoThisIsFor: data["who_this_is_for"],
            aboutThisCenter: data["about_center"],
            description: data["description"],
            email: data["email"],
            exams: data["exams"],
            location: data["location"],
            managedBy: data["managed_by"],
            modalities: data["modalities"],
            phone: data["phone"],
            subtitle: data["subtitle"],
            website: data["website"],
          ),
        );
      }
      availableReviewCenters.value = hubList;
      reviewCenterSection.value = availableReviewCenters.value;
    } catch (error) {
      rethrow;
    }
  }
}
