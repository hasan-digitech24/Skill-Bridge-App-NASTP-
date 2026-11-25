import 'package:flutter/material.dart';
import 'package:my_app/theme/app_colors_extension.dart';

export 'package:my_app/theme/app_colors_extension.dart';

class AppColors {
  /// Theme-aware accessor: gets dynamic colors for the active theme
  static AppColorsExtension of(BuildContext context) {
    return Theme.of(context).extension<AppColorsExtension>() ?? AppColorsExtension.light;
  }

  // Static constants retained for compatibility
  static const Color primary = Color(0xFF2863F0);
  static const Color navy = Color(0xFF111827);
  static const Color navyLight = Color(0xFF1F2937);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF4F7FC);
  static const Color lightBlue = Color(0xFFEFF5FF);

  static const Color green = Color(0xFF10B981);
  static const Color greenDark = Color(0xFF059669);
  static const Color greenLight = Color(0xFFECFDF5);
  static const Color greenBorder = Color(0xFF6EE7B7);

  static const Color red = Color(0xFFE11D48);
  static const Color redLight = Color(0xFFFEF2F2);

  static const Color orange = Color(0xFFF97316);
  static const Color orangeLight = Color(0xFFFFEFE0);

  static const Color amber = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFFF6E5);

  static const Color textGrey = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFEEF1F6);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x0D111827), blurRadius: 12, offset: Offset(0, 4)),
  ];
}
