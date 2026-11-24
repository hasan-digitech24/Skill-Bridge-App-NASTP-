import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/student_nav_controller.dart';
import 'package:my_app/theme/app_colors.dart';
import 'package:my_app/view/student_dashboard_screen.dart';
import 'package:my_app/view/sessions_screen.dart';
import 'package:my_app/view/student_profile_screen.dart';

class StudentShell extends StatelessWidget {
  const StudentShell({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentShellController());

        final pages = [
      const ExploreScreen(),
      const SessionsScreen(),  
      const StudentProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined), label: 'Sessions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}