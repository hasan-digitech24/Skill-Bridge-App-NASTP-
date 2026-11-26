import 'package:get/get.dart';
import 'package:my_app/controllers/student_nav_controller.dart';
import 'package:my_app/controllers/theme_controller.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/widgets/student/photo_options_sheet.dart';



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
  final _picker = ImagePicker();

  final imagePath = ''.obs;

  // The image to show: picked photo, or the default asset
  ImageProvider get imageProvider {
    if (imagePath.value.isEmpty) {
      return const AssetImage('assets/png/jamie.png');
    }
    if (kIsWeb) return NetworkImage(imagePath.value);
    return FileImage(File(imagePath.value));
  }

  // Opens the "Open camera / Select from Gallery" sheet
  void openPhotoSheet() {
    Get.bottomSheet(
      const PhotoOptionsSheet(),
      backgroundColor: Colors.transparent,
    );
  }

  // Closes the sheet, then opens the camera or gallery
  Future<void> pickImage(ImageSource source) async {
    Get.back();

    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
      );

      if (picked != null) {
        imagePath.value = picked.path;
        Get.snackbar('Done', 'Profile photo updated.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not open the camera or gallery.');
    }
  }

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
