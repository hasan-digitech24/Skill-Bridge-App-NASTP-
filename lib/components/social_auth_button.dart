import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/app_assets.dart';
import 'package:my_app/constants/app_strings.dart';

class SocialAuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String svgIconPath;

  const SocialAuthButton({
    super.key,
    required this.onPressed,
    this.text = AppStrings.google,
    this.svgIconPath = AppAssets.googleIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          side: BorderSide(color: colorScheme.outline, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgIconPath, width: 20.w, height: 20.h),
            SizedBox(width: 12.w),
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
