import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/app_top_nav_bar.dart';
import 'package:my_app/components/auth_prompt_text.dart';
import 'package:my_app/components/custom_primary_button.dart';
import 'package:my_app/components/custom_text_field.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/routes/app_routes.dart';
import 'package:my_app/widgets/auth/role_toggle_switch.dart';
import 'package:my_app/widgets/auth/terms_checkbox.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _selectedRoleIndex = 0; // 0 = Student, 1 = Tutor
  bool _agreedToTerms = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTopNavBar(
                title: AppStrings.createAccount,
                onBack: () => Get.back(),
              ),
            ),

            // Scrollable Form Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 6.h),

                    // Subtitle
                    Text(
                      AppStrings.createAccountSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Role Switcher (Student / Tutor)
                    RoleToggleSwitch(
                      selectedIndex: _selectedRoleIndex,
                      onRoleChanged: (index) {
                        setState(() {
                          _selectedRoleIndex = index;
                        });
                      },
                    ),

                    SizedBox(height: 18.h),

                    // Full Name Field
                    CustomTextField(
                      label: AppStrings.fullName,
                      hintText: AppStrings.enterFullName,
                      controller: _fullNameController,
                    ),

                    SizedBox(height: 14.h),

                    // Email Address Field
                    CustomTextField(
                      label: AppStrings.emailAddress,
                      hintText: AppStrings.emailPlaceholder,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),

                    SizedBox(height: 14.h),

                    // Phone Number Field
                    CustomTextField(
                      label: AppStrings.phoneNumber,
                      hintText: AppStrings.phonePlaceholder,
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                    ),

                    SizedBox(height: 14.h),

                    // Password Field
                    CustomTextField(
                      label: AppStrings.password,
                      hintText: AppStrings.passwordHintSignup,
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    SizedBox(height: 14.h),

                    // Confirm Password Field
                    CustomTextField(
                      label: AppStrings.confirmPassword,
                      hintText: AppStrings.confirmPasswordHint,
                      isPassword: true,
                      controller: _confirmPasswordController,
                    ),

                    SizedBox(height: 16.h),

                    // Terms and Conditions Checkbox
                    TermsCheckbox(
                      isChecked: _agreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreedToTerms = value;
                        });
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Create Account Button
                    CustomPrimaryButton(
                      text: AppStrings.createAccount,
                      hasShadow: true,
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
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
