import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTopNavBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;

  const AppTopNavBar({
    super.key,
    this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 48.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button with rounded box in dark mode
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: onBack ?? () => Get.back(),
              child: Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF242424) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  border: isDark
                      ? Border.all(color: const Color(0xFF333333), width: 1)
                      : null,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16.sp,
                  color: isDark ? Colors.white : colorScheme.onSurface,
                ),
              ),
            ),
          ),
          // Title (if any)
          if (title != null)
            Text(
              title!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
        ],
      ),
    );
  }
}
