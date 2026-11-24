import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/components/skill_bridge_logo.dart';
import 'package:my_app/constants/app_assets.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/widgets/onboarding/onboarding_badge.dart';

class OnboardingHeaderCard extends StatelessWidget {
  const OnboardingHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 480.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(44.r),
          bottomRight: Radius.circular(44.r),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(44.r),
          bottomRight: Radius.circular(44.r),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Bottom-left subtle decorative overlapping circles
            Positioned(
              left: -50.w,
              bottom: -40.h,
              child: Container(
                width: 200.w,
                height: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              left: 35.w,
              bottom: 25.h,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),

            // 2. Yellow/Orange diagonal bar on the right
            Positioned(
              right: -12.w,
              top: 160.h,
              child: Transform.rotate(
                angle: -0.45,
                child: Container(
                  width: 95.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                ),
              ),
            ),

            // 3. Prominent circular outline ring DIRECTLY BEHIND THE BOOK
            Positioned(
              top: 105.h,
              child: Container(
                width: 295.w,
                height: 295.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                    width: 1.5,
                  ),
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),

            // 4. Central Content: Logo on top, Book PNG Image + Badges in center
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SkillBridge Logo with White Container behind Icon
                    SkillBridgeLogo(
                      textColor: AppColors.white,
                      iconContainerSize: 38.w,
                      fontSize: 20.sp,
                      showWhiteContainer: true,
                    ),

                    const Spacer(),

                    // Central Book Illustration using actual asset PNG with Badges
                    Center(
                      child: SizedBox(
                        width: 310.w,
                        height: 220.h,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Book PNG asset from user's design (transparent background)
                            Image.asset(
                              AppAssets.bookIllustration,
                              width: 220.w,
                              height: 160.h,
                              fit: BoxFit.contain,
                            ),

                            // 4.9 rating badge (top left of book)
                            Positioned(
                              top: 14.h,
                              left: 14.w,
                              child: const OnboardingBadge(
                                rotation: -0.08,
                                leading: Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFF59E0B),
                                  size: 18,
                                ),
                                text: AppStrings.ratingBadge,
                              ),
                            ),

                            // Live learning badge (bottom right of book)
                            Positioned(
                              bottom: 14.h,
                              right: 12.w,
                              child: OnboardingBadge(
                                rotation: -0.04,
                                leading: SvgPicture.asset(
                                  AppAssets.videoIcon,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                text: AppStrings.liveLearningBadge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
