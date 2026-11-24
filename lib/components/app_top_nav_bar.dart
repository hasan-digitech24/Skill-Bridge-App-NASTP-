import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/app_colors.dart';

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
    return SizedBox(
      height: 48.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: onBack ?? () => Get.back(),
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18.sp,
                  color: AppColors.black,
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
                color: AppColors.black,
              ),
            ),
        ],
      ),
    );
  }
}
