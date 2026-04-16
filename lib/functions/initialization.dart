import 'package:hakbang/models/ai_message.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/database/database.dart';
import 'package:intl/intl.dart';

class Initialization {
  static void mainInitialization() async {
    await Database.getCollege();
    await Database.getScholarships();
    refreshChat();

    collegeSection.value = availableColleges.value;
    refreshCollegeSelection();
  }

  static void refreshCollegeSelection() {
    selectedSchoolHover.value = [];
    for (var element in collegeSection.value) {
      selectedSchoolHover.value.add(false);
    }
  }

  static void refreshChat() {
    chatMessages.value.clear();
    chatMessages.value.add(
      AiMessage(
        text:
            'Hi <Name>! 👋 I\'m Gabay, your college planning assistant. I can help you choose the right school, find scholarships, understand entrance exams, and calculate your UPG. What would you like to explore today?',
        role: "model",
        chatTime: DateFormat('hh:mm a').format(DateTime.now()),
      ),
    );
  }
}
