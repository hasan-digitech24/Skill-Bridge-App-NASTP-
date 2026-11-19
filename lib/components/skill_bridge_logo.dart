import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/app_assets.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/constants/app_strings.dart';

class SkillBridgeLogo extends StatelessWidget {
  final Color textColor;
  final double? iconContainerSize;
  final double? fontSize;
  final bool showWhiteContainer;

  const SkillBridgeLogo({
    super.key,
    this.textColor = AppColors.black,
    this.iconContainerSize,
    this.fontSize,
    this.showWhiteContainer = true,
  });

  @override
  Widget build(BuildContext context) {
    final double boxSize = iconContainerSize ?? 42.w;
    final double textSz = fontSize ?? 22.sp;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            color: showWhiteContainer ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: showWhiteContainer
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          padding: EdgeInsets.all(showWhiteContainer ? 6.r : 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              AppAssets.appIcon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          AppStrings.appName,
          style: GoogleFonts.plusJakartaSans(
            fontSize: textSz,
            fontWeight: FontWeight.w700,
            color: textColor,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
