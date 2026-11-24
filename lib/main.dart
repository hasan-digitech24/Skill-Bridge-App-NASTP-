import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_app/constants/app_strings.dart';
import 'package:my_app/controllers/theme_controller.dart';
import 'package:my_app/data/demo_data.dart';
import 'package:my_app/routes/app_pages.dart';
import 'package:my_app/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadTutorDemoData();
  Get.put(ThemeController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeController.themeMode,
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
