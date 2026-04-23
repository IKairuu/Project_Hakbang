import 'package:hakbang/functions/locations.dart';
import 'package:hakbang/functions/sorting_functions.dart';
import 'package:hakbang/models/ai_message.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';
import 'package:intl/intl.dart';

class Initialization {
  static Future<void> mainInitialization() async {
    await Locations.initializeLocationServices();
    userPosition.value = await Locations.getUserLocation();
    await Database.getCollege();
    await Database.getScholarships();
    await Database.getUserActivities(userCredentials.value!.email);
    await Database.getHubs();
    await Database.getSavedSchools(userCredentials.value!.email);
    await SortingFunctions.sortASctivities();
    await refreshChat();

    collegeSection.value = availableColleges.value;
    refreshCollegeSelection();
  }

  static void refreshCollegeSelection() {
    selectedSchoolHover.value = [];
    for (var element in collegeSection.value) {
      selectedSchoolHover.value.add(false);
    }
  }

  static Future<void> refreshChat() async {
    chatMessages.value.clear();
    chatMessages.value.add(
      AiMessage(
        text:
            'Hi ${userCredentials.value!.name.split(" ")[0]}! 👋 I\'m Gabay, your college planning assistant. I can help you choose the right school, find scholarships, understand entrance exams, and calculate your UPG. What would you like to explore today?',
        role: "model",
        chatTime: DateFormat('hh:mm a').format(DateTime.now()),
      ),
    );
  }
}
