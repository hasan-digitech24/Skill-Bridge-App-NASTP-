import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/app_top_nav_bar.dart';
import 'package:my_app/components/auth_prompt_text.dart';
import 'package:my_app/components/custom_primary_button.dart';
import 'package:my_app/components/custom_text_field.dart';
import 'package:my_app/components/skill_bridge_logo.dart';
import 'package:my_app/components/social_auth_button.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/widgets/auth/or_divider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Nav Bar with back arrow
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTopNavBar(
                onBack: () => Get.back(),
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // SkillBridge Logo with White Container
                    SkillBridgeLogo(
                      textColor: AppColors.black,
                      iconContainerSize: 38.w,
                      fontSize: 20.sp,
                      showWhiteContainer: true,
                    ),

                    SizedBox(height: 32.h),

                    // Welcome back Headline
                    Text(
                      AppStrings.welcomeBack,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      AppStrings.welcomeBackSubtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Email Field
                    CustomTextField(
                      label: AppStrings.emailAddress,
                      hintText: AppStrings.emailPlaceholder,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),

                    SizedBox(height: 18.h),

                    // Password Field
                    CustomTextField(
                      label: AppStrings.password,
                      hintText: AppStrings.passwordHintLogin,
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    SizedBox(height: 12.h),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Handle Forgot Password
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Login Button with Shadow
                    CustomPrimaryButton(
                      text: AppStrings.login,
                      hasShadow: true,
                      onPressed: () {
                        // Handle Login
                      },
                    ),

                    SizedBox(height: 28.h),

                    // Or Continue With Divider
                    const OrDivider(),

                    SizedBox(height: 24.h),

                    // Google Login Button
                    SocialAuthButton(
                      onPressed: () {
                        // Handle Google Sign-in
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Don't have an account? Sign Up
                    AuthPromptText(
                      normalText: AppStrings.dontHaveAccount,
                      actionText: AppStrings.signUp,
                      onActionTap: () {
                        Get.toNamed(AppRoutes.signUp);
                      },
                    ),

                    SizedBox(height: 24.h),
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
