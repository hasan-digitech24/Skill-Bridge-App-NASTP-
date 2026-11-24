import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/auth_prompt_text.dart';
import 'package:my_app/components/custom_primary_button.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/widgets/onboarding/onboarding_header_card.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          // Top Curved Card with Illustration, Circle behind book, and Logo
          const OnboardingHeaderCard(),

          // Bottom Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.h),

                  // Tagline: LEARN · GROW · ACHIEVE
                  Text(
                    AppStrings.tagline,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                      letterSpacing: 2.2,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Headline: "Learn from the best,\nanywhere." (two colors)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppStrings.onboardingTitlePart1,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                        height: 1.25,
                        letterSpacing: -0.5,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.onboardingTitlePart2,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.primary,
                            height: 1.25,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Subtitle
                  Text(
                    AppStrings.onboardingSubtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Get Started Button
                  CustomPrimaryButton(
                    text: AppStrings.getStarted,
                    showTrailingArrow: true,
                    hasShadow: true,
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                  ),

                  SizedBox(height: 18.h),

                  // Already have an account? Login
                  AuthPromptText(
                    normalText: AppStrings.alreadyHaveAccount,
                    actionText: AppStrings.login,
                    onActionTap: () {
                      Get.toNamed(AppRoutes.login);
                    },
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
