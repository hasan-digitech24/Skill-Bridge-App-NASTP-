import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors_extension.dart';

export 'package:my_app/theme/app_colors_extension.dart';

class AppTheme {
  static const String fontFamily = 'Plus Jakarta Sans';

  /// Light Theme (Figma colors for Auth & Student screens)
  static ThemeData lightTheme() {
    const primaryColor = Color(0xFF2863F0);
    const scaffoldBg = Color(0xFFF4F7FC);
    const surfaceColor = Color(0xFFFFFFFF);
    const onSurfaceColor = Color(0xFF111827);
    const secondaryTextColor = Color(0xFF6B7280);
    const outlineColor = Color(0xFFE5E7EB);
    const hintColor = Color(0xFF9CA3AF);
    const toggleContainerColor = Color(0xFFF1F5F9);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scaffoldBg,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        onSurfaceVariant: secondaryTextColor,
        outline: outlineColor,
        outlineVariant: hintColor,
        primaryContainer: Color(0xFFEFF5FF),
        onPrimaryContainer: primaryColor,
        surfaceContainerHighest: toggleContainerColor,
      ),
      dividerColor: const Color(0xFFEEF1F6),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFF9CA3AF),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      extensions: const [
        AppColorsExtension.light,
      ],
    );
  }

  /// Dark Theme (Exact Figma Colors from Dark Mode design & dark extension)
  static ThemeData darkTheme() {
    const primaryColor = Color(0xFF2860F1); // Figma primary button blue
    const scaffoldBg = Color(0xFF121212); // Figma dark background
    const surfaceColor = Color(0xFF242424); // Figma dark input field / card fill
    const onSurfaceColor = Color(0xFFFFFFFF); // Figma white headings and labels
    const secondaryTextColor = Color(0xFFA1A1AA); // Figma muted subtitle text
    const outlineColor = Color(0xFF333333); // Figma dark border
    const hintColor = Color(0xFF71717A); // Figma placeholder hint text
    const toggleContainerColor = Color(0xFF2C2C2E); // Figma dark segmented container

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scaffoldBg,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        onSurfaceVariant: secondaryTextColor,
        outline: outlineColor,
        outlineVariant: hintColor,
        primaryContainer: Color(0xFF1E293B),
        onPrimaryContainer: primaryColor,
        surfaceContainerHighest: toggleContainerColor,
      ),
      dividerColor: const Color(0xFF2C2C2E),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xFF71717A),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      extensions: const [
        AppColorsExtension.dark,
      ],
    );
  }
}
