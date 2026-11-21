import 'package:flutter/material.dart';

import 'data/demo_data.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  loadTutorDemoData();
  runApp(const TutorApp());
}

class TutorApp extends StatelessWidget {
  const TutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutor Finder',
      theme: AppTheme.light,
      initialRoute: AppRoutes.tutorHome,
      routes: AppRoutes.routes,
    );
  }
}
