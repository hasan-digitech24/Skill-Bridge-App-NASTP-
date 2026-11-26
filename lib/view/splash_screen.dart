import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/skill_bridge_logo.dart';
import 'package:my_app/constants/app_assets.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Get.offNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkillBridgeLogo(
              iconContainerSize: 80,
              fontSize: 26,
              showWhiteContainer: true,
              isShowText: false,
            ),
            SizedBox(height: 12.h),
            Text(
              AppStrings.appName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                color: colorScheme.onPrimary,
                height: 1.25,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image.asset(AppAssets.splash, width: 200.w, fit: BoxFit.contain),
      //       Text(
      //         AppStrings.appName,
      //         style: GoogleFonts.plusJakartaSans(
      //           fontSize: 25.sp,
      //           fontWeight: FontWeight.w800,
      //           color: colorScheme.onPrimary,
      //           height: 1.25,
      //           letterSpacing: -0.5,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
