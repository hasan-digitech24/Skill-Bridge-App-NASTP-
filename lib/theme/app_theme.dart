import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Plus Jakarta Sans';

  // Light Theme (Exact Figma Colors)
  static ThemeData lightTheme() {
    const primaryColor = Color(0xFF2563EB);
    const scaffoldBg = Color(0xFFFFFFFF);
    const surfaceColor = Color(0xFFFFFFFF);
    const onSurfaceColor = Color(0xFF0F172A);
    const secondaryTextColor = Color(0xFF64748B);
    const outlineColor = Color(0xFFE2E8F0);
    const hintColor = Color(0xFF94A3B8);
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
        surfaceContainerHighest: toggleContainerColor,
      ),
      dividerColor: outlineColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }

  // Dark Theme (Exact Figma Colors from Dark Mode design)
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
        surfaceContainerHighest: toggleContainerColor,
      ),
      dividerColor: const Color(0xFF2C2C2E),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
