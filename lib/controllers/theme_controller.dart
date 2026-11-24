import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  /// Changes the theme to light or dark
  void changeTheme(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    debugPrint("=== [THEME SWITCH] Mode changed to: ${mode == ThemeMode.dark ? 'DARK' : 'LIGHT'} ===");
  }

  /// Toggles between light and dark theme
  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      changeTheme(ThemeMode.dark);
    } else {
      changeTheme(ThemeMode.light);
    }
  }
}
