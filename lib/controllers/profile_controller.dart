import 'package:get/get.dart';
import 'package:my_app/controllers/student_nav_controller.dart';
import 'package:my_app/controllers/theme_controller.dart';

class ProfileController extends GetxController {
  // Demo data (replace with real user data later)
  final name = 'Jamie Roberts';
  final email = 'jamie@example.com';
  final memberSince = 'Student since January 2025';

  final sessionsCount = 12;
  final learningHours = '18h';
  final savedCount = 6;

  final interests = ['Flutter', 'Math', 'Physics'];

  // Switches
  final pushOn = true.obs;
  final remindersOn = true.obs;
  final darkOn = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<ThemeController>()) {
      darkOn.value = Get.find<ThemeController>().isDarkMode;
    }
  }

  void togglePush() => pushOn.value = !pushOn.value;
  void toggleReminders() => remindersOn.value = !remindersOn.value;

  void toggleDark() {
    if (Get.isRegistered<ThemeController>()) {
      Get.find<ThemeController>().toggleTheme();
      darkOn.value = Get.find<ThemeController>().isDarkMode;
    } else {
      darkOn.value = !darkOn.value;
    }
  }

  void openTab(int index) {
    Get.back();
    Get.find<StudentShellController>().changeTab(index);
  }

  void showMessage(String text) {
    Get.snackbar('Coming soon', text);
  }
}
