import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/app_colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool showTrailingArrow;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color textColor;
  final double? borderRadius;
  final bool hasShadow;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.showTrailingArrow = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.borderRadius,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final double btnHeight = height ?? 54.h;
    final double radius = borderRadius ?? 16.r;

    return Container(
      width: width ?? double.infinity,
      height: btnHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: (hasShadow && onPressed != null && !isLoading)
            ? [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  if (showTrailingArrow) ...[
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18.sp,
                      color: textColor,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
